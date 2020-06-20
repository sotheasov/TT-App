//
//  Ticket.swift
//  TurboTech
//
//  Created by sq on 6/19/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Ticket {
    var id : Int { get }
    var name : String { get }
}

class TicketStatus : Ticket {
    var id: Int
    var name: String
    init(json : JSON){
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
    }
}

class TicketCategory : Ticket {
    var id: Int
    var name: String
    init(json : JSON){
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
    }
}

class TicketSeverity : Ticket {
    var id: Int
    var name: String
    init(json : JSON){
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
    }
}

class TicketProduct : Ticket {
    var id: Int
    var name: String
    var unitPrice : Double
    var commissionRate : Double
    var quantity : Int
    init(json : JSON){
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.unitPrice = json["unit_price"].doubleValue
        self.commissionRate = json["commission Rate"].doubleValue
        self.quantity = json["qty"].intValue
    }
}

class TicketContact{
    var id : Int
    var accountId : Int
    var contactNo : String
    var firstName : String
    var lastName : String
    var organization : String
    var email : String
    var province : String
    var country : String
    init(json : JSON){
        self.id = json["id"].intValue
        self.accountId = json["accoun_id"].intValue
        self.contactNo = json["contact_no"].stringValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.organization = json["organization"].stringValue
        self.email = json["eamil"].stringValue
        self.province = json["province"].stringValue
        self.country = json["country"].stringValue
    }
}
