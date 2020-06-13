//
//  LoginViewModel.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/22/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation

class LoginViewModel {
    var loginService = LoginService()
    
//    func userLogin(username : String){
//        loginService?.userLogin(username: username)
//    }
//    func userLogin(username : String, handler: @escaping(_ name : String)->()){
//        loginService?.userLogin(username: username, handler: { (str) in
//            print(str)
//            handler("crm")
//        })
//    }
    
    func userLogin(username : String, password : String, handler: @escaping(_ isLogin : Bool, _ user : User?)->Void){
        loginService.userLogin(username: username, password: password , handler: { (user) in
            if user != nil {
                print("vm true")
                handler(true, user)
            } else {
                print("vm false")
                handler(false, user)
            }
        })
    }
    
    func fetchCurrentUser(){
        guard let username = UserDefaults.standard.string(forKey: "curUsername"),
            let password = UserDefaults.standard.string(forKey: "curPassword") else {
                UserDefaults.standard.set(false, forKey: "isLogin")
                return
        }
        loginService.userLogin(username: username, password: password) { (user) in
            AppDelegate.user = user
        }
    }
}

//extension LoginViewModel : LoginServiceDelegate{
//    func responseUser(user: String) {
//        print("View model : ", user)
//    }
//}
