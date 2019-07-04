//
//  ViewController.swift
//  mvvm-rxswift-boilerplate
//
//  Created by Delfín Hernández Gómez on 02/05/2019.
//  Copyright © 2019 Delfín Hernández Gómez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    let viewModel : LoginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        bindCallBacks()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func bindViewModel() {
        
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.mailData)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.passData)
            .disposed(by: disposeBag)
    
        loginButton
            .rx
            .tap
            .do(
                onNext:  {
                    [unowned self] in
                        self.emailTextField.resignFirstResponder()
                        self.passwordTextField.resignFirstResponder()})
            .subscribe(
                onNext: {
                    [unowned self] in
                        if self.viewModel.validateCredentials() {
                            self.viewModel.login()
                        }})
            .disposed(by: disposeBag)
    }

    func bindCallBacks() {
        
        // success
        viewModel.isSuccess.asObservable()
            //.observeOn(MainScheduler.instance)
            .bind{ value in
                NSLog("Login ok")
            }.disposed(by: disposeBag)
        
        // errors
        viewModel.errorMsg.asObservable()
            .bind { errorMessage in
                // Show error
                NSLog("Login ko")
            }.disposed(by: disposeBag)
        
    }

}

