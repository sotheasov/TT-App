//
//  LoginService.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/22/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginService {
    
//    var loginServiceDelegate : LoginServiceDelegate?
//
//    func userLogin(username : String){
//        // user login was called from view model
//        // and fetch data
//        // User, status
//        // get data hz
//        // tver mix ban pass datqa to view model vinh
//        self.loginServiceDelegate?.responseUser(user: "response \(username)")
//    }
//    func userLogin(username : String, handler: @escaping((_ name : String)->())){
//    }
    func userLogin(username : String, password : String, handler: @escaping(_ user : User?)->()) {
        var user : User?
        // build parameters
        let parameters = ["username": username, "pass": password]

        // build request
        AF.request(APIManager.LOGIN.POST, method: .post , parameters: parameters).response { (response) in
            guard let data = response.data else { return }
            if let jsons = try? JSON(data: data) {
                print("Fetch user ban")
                for json in jsons["result"].arrayValue {
                    user = User(json: json)
                }
            } else {
                print("fetch user ot ban")
                user = nil
            }
            handler(user)
        }
    }
}

//protocol LoginServiceDelegate {
//    func responseUser(user : String)
//}
