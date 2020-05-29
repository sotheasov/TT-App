//
//  Department.swift
//  TurboTech
//
//  Created by sq on 5/27/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation

enum Position {
    case Sale
    case Admin
    case Finance
    case HR
}

enum Sale {
    case Product
    case Pop
    case Device
    case CRM
}

class Department {
    let id : Int
    let name : String
    let image : String
    var position : Position?
    var sale : Sale?
    
    init(id : Int, name : String, image : String, position : Position){
        self.id = id
        self.name = name
        self.image = image
        self.position = position
    }
    
    init(id : Int, name : String, image : String, sale : Sale){
        self.id = id
        self.name = name
        self.image = image
        self.sale = sale
    }
}