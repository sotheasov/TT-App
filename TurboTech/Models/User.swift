//
//  User.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/22/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import SwiftyJSON

class User : NSObject, NSCoding{
    
    var id : String
    var fullName : String
    var userName : String
    var positon : Position
    var imageUrl : String
    var phone : String
    
//    init(){
//        self.id = "0"
//        self.userName = "Unknown"
//        self.positon = "Unknown"
//        self.imageUrl = "default"
//    }
    
    init(json: JSON){
        print(json["ID Card"].stringValue)
        print(json["Full Name"].stringValue)
        print(json["Full Name"].stringValue)
        print(json["Position"].stringValue)
        print(json["Phone"].stringValue)
        self.id = json["ID Card"].stringValue
        self.fullName = json["Full Name"].stringValue
        self.userName = json["User Name"].stringValue
        self.positon = Position(rawValue: json["Position"].stringValue)!
        self.imageUrl = APIManager.IMAGE_PRO + json["Image"].stringValue
        self.phone = json["Phone"].stringValue
        
    }
    
    init(id : String, fullName : String, userName : String, position : Position, imageUrl : String, phone : String) {
        self.id = id
        self.userName = userName
        self.fullName = fullName
        self.positon = position
        self.imageUrl = imageUrl
        self.phone = phone
    }
    
    required convenience init(coder aDecoder : NSCoder){
        let id = aDecoder.decodeObject(forKey: "id") as! String
        let userName = aDecoder.decodeObject(forKey: "userName") as! String
        let fullName = aDecoder.decodeObject(forKey: "fullName") as! String
        let postion = Position(rawValue: aDecoder.decodeObject(forKey: "position") as! String)!
        let imageUrl = aDecoder.decodeObject(forKey: "imageUrl") as! String
        let phone = aDecoder.decodeObject(forKey: "phone") as! String
        self.init(id : id, fullName : fullName, userName : userName, position : postion, imageUrl : imageUrl, phone : phone)
    }
    
    func encode(with aCoder : NSCoder){
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.userName, forKey: "userName")
        aCoder.encode(self.fullName, forKey: "fullName")
        aCoder.encode(self.positon.rawValue,forKey: "postion")
        aCoder.encode(self.imageUrl, forKey: "imageUrl")
        aCoder.encode(self.phone, forKey: "phone")
    }
    
    static func resetUser(){
        let userDefault = UserDefaults.standard
        userDefault.set(false, forKey: "isLogin")
        AppDelegate.user = nil
        userDefault.set(nil, forKey: "curUsername")
        userDefault.set(nil, forKey: "curPassword")
        userDefault.synchronize()
    }
    
    static func setupUser(username : String, password : String, user : User){
        let userDefault = UserDefaults.standard
        userDefault.set(true, forKey: "isLogin")
        AppDelegate.user = user
        userDefault.set(username, forKey: "curUsername")
        userDefault.set(password, forKey: "curPassword")
        userDefault.synchronize()
    }
    
    static func setNewPassword(password : String){
        let userDefault = UserDefaults.standard
        userDefault.set(true, forKey: "isLogin")
        userDefault.set(password, forKey: "curPassword")
        userDefault.synchronize()
    }
}
