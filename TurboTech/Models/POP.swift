//
//  POP.swift
//  TurboTech
//
//  Created by sq on 5/26/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import SwiftyJSON
//import MapKit
//import Contacts

class POP {
    let code : Int
    let nameEn : String
    let nameKh : String
    let latitude : Double
    let longitude : Double
//    let coordinate: CLLocationCoordinate2D
    
    init(json : JSON){
        self.code = json["code"].intValue
        self.nameEn = json["Name"].stringValue
        self.nameKh = json["Name kh"].stringValue
        print(json["lat"].stringValue, json["lng"].stringValue)
        self.latitude = json["lat"].doubleValue //Double("11.620456")!
        self.longitude = json["lng"].doubleValue //Double("104.891839")!
    }
}
/*
"code": "1",
"Name": "Obek Kaorm",
"Name kh": "Mohanokor HQ",
"lat": "11.554907",
"lng": "104.886759",
"latlng": "11.554907,104.886759"
*/
/*
let position1 = CLLocationCoordinate2D(latitude: 11.620456, longitude: 104.891939)
let marker1 = GMSMarker(position: position1)
marker1.title = "Hello World 1"
var pop = UIImage(named: "pop_1x")
pop = pop?.imageResize(sizeChange: CGSize(width: 32, height: 48))
marker1.icon = pop
*/
