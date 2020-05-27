//
//  PackageDetail.swift
//  TurboTech
//
//  Created by sq on 5/22/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import SwiftyJSON

class PackageDetail {
    var id : Int
    var nameEn : String
    var nameKh : String
    var price : String
    var speed : String
    var detailEn : String
    var detailKh : String
    var packageId : Int
    var serviceId : Int
    
    init(json : JSON){
        self.id = json["id"].intValue
        self.nameEn = json["name en"].stringValue
        self.nameKh = json["name kh"].stringValue
        self.price = json["price"].stringValue
        self.speed = json["speed"].stringValue
        self.detailEn = json["product_fea_en"].stringValue
        self.detailKh = json["product_fea_kh"].stringValue
        self.packageId = json["package_id"].intValue
        self.serviceId = json["service_id"].intValue
    }
    init(){
        self.id = 11
        self.detailEn = "hhh"
        self.detailKh = "ហហហ"
        self.nameEn = "ABC"
        self.nameKh = ""
        self.packageId = 10
        self.price = "100"
        self.speed = "10"
        self.serviceId = 10
    }
    
    func setDetailEn(str : String){
        self.detailEn = str
    }
    
    func setDetailKh(str : String){
        self.detailKh = str
    }
}

/*
 "id": 11,
 "name en": "Silver Package",
 "name kh": "Silver Package",
 "price": "100",
 "speed": "1 Mbps",
 "product_fea_en": "▒1 Mbps▒Public IP (DHCP)▒Service Level Agreement 99.90%▒Network Monitoring System 24/7▒Hotline Support 24/7▒Free Public IP 1 IP▒Media Convertor (M/C) $35▒Installation $100",
 "speproduct_fea_kh": "▒1 Mbps▒Public IP (DHCP)▒Service Level Agreement 99.90%▒Network Monitoring System 24/7▒Hotline Support 24/7▒Free Public IP 1 IP▒Media Convertor (M/C) $35▒Installation $100",
 "package_id": 7,
 "service_id": 0
 */
