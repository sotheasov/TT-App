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
    
    func userChangePassword(username : String, oldPass : String, newPass : String, handler: @escaping(_ done : Bool, _ state : String)->()){
        
        let parameters = ["username" : username, "old_pass" : oldPass, "new_pass" : newPass]
        var status = false
        var state = ""
        AF.request(APIManager.LOGIN.POST_PW, method: .post , parameters: parameters).response { (response) in
            print("min torn jol change ")
            
            guard let data = response.data else {
                print(" pre data")
                return
            }
            print(data)
            if let json = try? JSON(data: data) {
                print(json)
                state = json["pass"].stringValue
                if  state == "true" {
                    status = true
                    print("change ban hz")
                } else {
                    status = false
                    print("change !ban hz")
                }
            } else {
                print("change ot ban")
                status = false
            }
            handler(status, state)
        }
    }
}
