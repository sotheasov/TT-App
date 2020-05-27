//
//  ServiceService.swift
//  TurboTech
//
//  Created by sq on 5/21/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProductService {
    var productServiceDelegate : ProductServiceDelegate?
    let headers : HTTPHeaders = APIManager.HEADER
    
    func fetchAllProducts(){
        var products = [Product]()
        AF.request("\(APIManager.PRODUCT.GET)", method: .get, headers: headers).response { (response) in
            guard let data = response.data else { return }
            if let jsons = try? JSON(data: data){
                for json in jsons["result"].arrayValue {
                    let pro = Product(json: json)
                    print(pro.id)
                    products.append(pro)
                }
            }
            print("Product Server : ",products)
            self.productServiceDelegate?.responseProduct(products: products)
        }
    }
    
    func fetchAllPackage(type : Int){
        var packages = [Package]()
        AF.request("\(APIManager.PACKAGE.GET)", method: .get, headers: headers).response { (response) in
            guard let data = response.data else { return }
            if let jsons = try? JSON(data: data){
                for json in jsons["result"].arrayValue {
                    let package = Package(json: json)
                    print(package.id)
                    packages.append(package)
                }
            }
            print("Product Server : ",packages)
            self.productServiceDelegate?.responsePackage(type : type, packages: packages)
        }
    }
    
    func fetchPackageDetail(packageId : Int){
        var details = [PackageDetail]()
        AF.request("\(APIManager.PACKAGE.GET_DETAIL)", method: .get, headers: headers).response { (response) in
            guard let data = response.data else { return }
            if let jsons = try? JSON(data: data){
                for json in jsons["result"].arrayValue {
                    let package = PackageDetail(json: json)
                    print("Detail : ", package.id)
                    details.append(package)
                }
            }
            self.productServiceDelegate?.responsePackageDetail(packageId : packageId, packageDetails: details)
        }
    }
    
    func fetchSoftwareSolution(){
        var softwareList = [SoftwareSolution]()
        AF.request("\(APIManager.PACKAGE.GET_SOFTWARE_SOLUTIOLN)", method: .get, headers: headers).response { (response) in
            guard let data = response.data else { return }
            if let jsons = try? JSON(data: data){
                for json in jsons["result"].arrayValue {
                    let software = SoftwareSolution(json: json)
                    print("Detail : ", software.id)
                    softwareList.append(software)
                }
            }
            self.productServiceDelegate?.responseSoftwareSolution(solutions: softwareList)
        }
    }
}
