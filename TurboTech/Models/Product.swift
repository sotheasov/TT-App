//
//  Service.swift
//  TurboTech
//
//  Created by sq on 5/21/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import SwiftyJSON

class Product {
    var id : Int
    var nameEn : String
    var nameKh : String
    var imageUrl : String
    
    init(id : Int, nameEn : String, nameKh : String, imageUrl : String){
        self.id = id
        self.nameEn = nameEn
        self.nameKh = nameKh
        self.imageUrl = imageUrl
    }
    
    init(json : JSON) {
        self.id = json["id"].intValue
        self.nameEn = json["name en"].stringValue
        self.nameKh = json["name kh"].stringValue
        self.imageUrl = APIManager.IMAGE_URL + json["image"].stringValue
        print(self.imageUrl)
    }
}
