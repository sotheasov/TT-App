//
//  Image.swift
//  TurboTech
//
//  Created by sq on 6/15/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import SwiftyJSON

class HomeImage {
    var title : String
    var imageEn : String
    var imageKh : String
    
    init(json : JSON){
        self.title = json["title"].stringValue
        self.imageEn = APIManager.IMAGE_EN + json["img_en"].stringValue
        self.imageKh = APIManager.IMAGE_KH + json["img_kh"].stringValue
    }
}
