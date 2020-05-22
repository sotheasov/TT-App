//
//  ServiceServiceDelegate.swift
//  TurboTech
//
//  Created by sq on 5/21/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation

protocol ProductServiceDelegate {
    func responseProduct(products : [Product])
    func responsePackage(type : Int, packages : [Package])
}
