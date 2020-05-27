//
//  User.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/22/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    var id : String
    var userName : String
    var positon : String
    var imageUrl : String
    
    init(){
        self.id = "0"
        self.userName = "Unknown"
        self.positon = "Unknown"
        self.imageUrl = "default"
    }
    
    init(json: JSON){
        self.id = json["ID Card"].stringValue
        self.userName = json["Full Name"].stringValue
        self.positon = json["Position"].stringValue
        self.imageUrl = json["Image"].stringValue
    }
}
