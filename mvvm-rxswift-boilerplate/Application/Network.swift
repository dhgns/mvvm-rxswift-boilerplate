//
//  Network.swift
//  mvvm-rxswift-boilerplate
//
//  Created by Delfín Hernández Gómez on 03/07/2019.
//  Copyright © 2019 Delfín Hernández Gómez. All rights reserved.
//

import RxSwift
import Alamofire


class APIManager {
    
    enum ApiResult {
        case success(Data)
        case failure(RequestError)
    }

    enum RequestError: Error {
        case unknownError
        case connectionError
        case authorizationError(Data)
        case invalidRequest
        case notFound
        case invalidResponse
        case internalServerError
        case serverError
        case serverUnavailable
        case forbidden
    }
    
    
    static func login(userId: String, password:String) -> Observable<EmployeeResponse> {
        return request(APIRouter.getEmployees())
    }
    
    static func getEmployees() -> Observable<EmployeeResponse> {
        return request(APIRouter.getEmployees())
    }
    
    
    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        
        return Observable<T>.create { observer in
    
            let request = AF.request(urlConvertible).responseDecodable { (response:DataResponse<T>) in

                    //Check the result from Alamofire's response and check if it's a success or a failure

                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure(let error):
                            switch response.response?.statusCode{
                            case 403:
                                observer.onError(RequestError.forbidden)
                            case 404:
                                observer.onError(RequestError.notFound)
                            case 500:
                                observer.onError(RequestError.internalServerError)
                            default:
                                observer.onError(error)
                            }
                    }
                }
            
                return Disposables.create {
                    request.cancel()
                }
        }
        
    }
        
    
}

enum APIRouter: URLRequestConvertible {
    
    //Endpoints
    case getEmployees()
    case getPosts(userId: Int)
    case doLogin(userId: String, password: String)
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    //MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    private var method: HTTPMethod {
        switch self {
        case .getPosts, .getEmployees, .doLogin:
            return .get
        }
    }
    
    //MARK: - Path
    //The path is the part following the base url
    private var path: String {
        switch self {
        case .getPosts:
            return "posts"
        case .getEmployees:
            return "mutua-connect/empleados"
        case .doLogin(_, _):
            return ""
        }
    }
    
    //MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    private var parameters: Parameters? {
        switch self {
        case .getPosts(let userId):
            //A dictionary of the key (From the constants file) and its value is returned
            return [Constants.Parameters.userId : userId]
        case .getEmployees:
            return nil
        case .doLogin( _, _):
            return nil
        }
    }
    
    
}
