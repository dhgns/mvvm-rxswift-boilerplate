//
//  Constants.swift
//  mvvm-rxswift-boilerplate
//
//  Created by Delfín Hernández Gómez on 02/05/2019.
//  Copyright © 2019 Delfín Hernández Gómez. All rights reserved.
//

import Foundation

struct Constants {
    
    static let baseUrl = "http://0.0.0.0"
    
    //The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
    
}
