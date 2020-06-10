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
    func userLogin(username : String, password : String, handler: @escaping(_ user : User)->Void) {
        var user : User?
        // build parameters
        let parameters = ["username": "thon", "pass": "111"]

        // build request
        AF.request(APIManager.LOGIN.POST, method: .post , parameters: parameters).response { (response) in
            guard let data = response.data else { return }
            let jsons = try? JSON(data: data)
            if jsons == nil {
                handler(User())
                return
            }
            for json in jsons!["result"].arrayValue {
//                print(json)
                user = User(json: json)
            }
            handler(user!)
        }
        
    }
    
}

//protocol LoginServiceDelegate {
//    func responseUser(user : String)
//}
