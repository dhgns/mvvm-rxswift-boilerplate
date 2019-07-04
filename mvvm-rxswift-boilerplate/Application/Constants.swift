//
//  Constants.swift
//  mvvm-rxswift-boilerplate
//
//  Created by Delfín Hernández Gómez on 02/05/2019.
//  Copyright © 2019 Delfín Hernández Gómez. All rights reserved.
//

import Foundation

struct Constants {
    
    static let baseUrl = "http://ec2-54-154-76-120.eu-west-1.compute.amazonaws.com/"
    
    struct Parameters {
        static let userId = "userId"
    }
    
    //The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
    
        
}
