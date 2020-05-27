//
//  POP.swift
//  TurboTech
//
//  Created by sq on 5/26/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import SwiftyJSON
import MapKit
import Contacts

class POP {
    let code : Int
    let nameEn : String
    let nameKh : String
    let latitude : Float
    let longitude : Float
//    let coordinate: CLLocationCoordinate2D
    
    init(json : JSON){
        self.code = json["code"].intValue
        self.nameEn = json["Name"].stringValue
        self.nameKh = json["Name kh"].stringValue
        self.latitude = json["lat"].floatValue
        self.longitude = json["lng"].floatValue
//        self.coordinate = json["latlng"].
//        self.coordinate =
    }
    
//    init(code : Int, nameEn : String, nameKh : String, latitude : Float, longitude : Float, coordinate : CLLocationCoordinate2D){
//        self.code = code
//        self.nameEn = nameEn
//        self.nameKh = nameKh
//        self.latitude = latitude
//        self.longitude = longitude
//        print("INIT self 4")
//        self.coordinate = coordinate
//        print("INIT self 5")
//    }
//
//    var title : String? {
//        return nameEn
//    }
//
//    var subtitle : String? {
//        return nameEn
//    }
//
//    var subTitleKh : String? {
//        return nameKh
//    }
//
//    var image : UIImage {return UIImage(named: "Flag")!}
}
/*
"code": "1",
"Name": "Obek Kaorm",
"Name kh": "Mohanokor HQ",
"lat": "11.554907",
"lng": "104.886759",
"latlng": "11.554907,104.886759"
*/
