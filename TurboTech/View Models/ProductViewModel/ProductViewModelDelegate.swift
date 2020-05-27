//
//  ServiceViewModelDelegate.swift
//  TurboTech
//
//  Created by sq on 5/21/20.
//  Copyright © 2020 TurboTech. All rights reserved.
// 2

import Foundation

protocol ProductViewModelDelegate {
    func responseProduct(products : [Product])
    func responsePackage(packages : [Package])
    func responsePackageDetail(packageDetails : [PackageDetail])
    func responseSoftwareSolution(solutions : [SoftwareSolution])
}
