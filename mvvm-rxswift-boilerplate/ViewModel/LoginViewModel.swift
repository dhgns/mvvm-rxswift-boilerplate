//
//  LoginViewModel.swift
//  mvvm-rxswift-boilerplate
//
//  Created by Delfín Hernández Gómez on 02/05/2019.
//  Copyright © 2019 Delfín Hernández Gómez. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let model : LoginModel = LoginModel()
    let disposebag: DisposeBag = DisposeBag()
    
    var mailErrorMsg = "Introduzca un mail válido"
    var passErrorMsg = "Introduzca una contraseña válida"
    
    var mailData: Variable<String> = Variable("")
    var passData: Variable<String> = Variable("")
    
    var mailErrorValue: Variable<String?> = Variable("")
    var passErrorValue: Variable<String?> = Variable("")
    
    // Fields that bind to our view's
    let isSuccess : Variable<Bool> = Variable(false)
    let isLoading : Variable<Bool> = Variable(false)
    let errorMsg : Variable<String> = Variable("")

    func validateCredentials () -> Bool{
        
        guard validatePattern(text: mailData.value) else {
            mailErrorValue.value = mailErrorMsg
            return false
        }
        
        guard validateLength(text: passData.value, size: (6,15)) else{
            passErrorValue.value = passErrorMsg
            return false;
        }
        
        mailErrorValue.value = ""
        passErrorValue.value = ""
        
        return true
    }
    
    func validateLength(text : String, size : (min : Int, max : Int)) -> Bool{
        return (size.min...size.max).contains(text.count)
    }
    
    func validatePattern(text : String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
    
    func login() {
        
        model.email = mailData.value
        model.password = passData.value
        
        isLoading.value = true
        
        sleep(3000)
        
        isLoading.value = false
        isSuccess.value = true
        
        
        
    }
    
}
