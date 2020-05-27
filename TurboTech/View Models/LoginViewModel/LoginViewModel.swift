//
//  LoginViewModel.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/22/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation

class LoginViewModel {
    var loginService : LoginService?
    
    init(){
        loginService = LoginService()
//        loginService?.loginServiceDelegate = self
    }
    
//    func userLogin(username : String){
//        loginService?.userLogin(username: username)
//    }
//    func userLogin(username : String, handler: @escaping(_ name : String)->()){
//        loginService?.userLogin(username: username, handler: { (str) in
//            print(str)
//            handler("crm")
//        })
//    }
    
    func userLogin(username : String, password : String, handler: @escaping(_ user : User)->Void){
        loginService?.userLogin(username: username, password: password , handler: { (user) in
            handler(user)
        })
    }
}

//extension LoginViewModel : LoginServiceDelegate{
//    func responseUser(user: String) {
//        print("View model : ", user)
//    }
//}
