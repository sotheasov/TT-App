//
//  Device.swift
//  TurboTech
//
//  Created by sq on 5/28/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import SwiftyJSON

class Device {
    var name : String
    var price : Double
    
    init(json : JSON){
        self.name = json["Name"].stringValue
        
        self.price = round(json["Price"].doubleValue * 10000) / 10000
    }
}
