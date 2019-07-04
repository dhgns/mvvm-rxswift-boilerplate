//
//  LoginModel.swift
//  mvvm-rxswift-boilerplate
//
//  Created by Delfín Hernández Gómez on 02/05/2019.
//  Copyright © 2019 Delfín Hernández Gómez. All rights reserved.
//

import Foundation


class LoginModel: Codable {
    
    var email = ""
    var password = ""
    
    convenience init(email : String, password : String) {
        self.init()
        self.email = email
        self.password = password
    }
    
    
}

class Employee: Codable {
    let id: String
    let nombre: String
    let apellidos: String
    let avatar: String
    let empresa: String
    let unidad: String
    let telefono: String
    let email: String
}

class EmployeeResponse: Codable {
    
    let empleados: [Employee]
    
}
