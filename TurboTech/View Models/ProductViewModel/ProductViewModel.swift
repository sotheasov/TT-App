//
//  File.swift
//  TurboTech
//
//  Created by sq on 5/21/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation

class ProductViewModel {
    var productViewModelDelegate : ProductViewModelDelegate?
    var productService : ProductService?
    
    init(){
        productService = ProductService()
        productService?.productServiceDelegate = self
    }
    
    func fetchAllProducts(){
        productService?.fetchAllProducts()
    }
    
    func fetchAllPackage(type : Int){
        productService?.fetchAllPackage(type: type)
    }
    func fetchPackageDetail(packageId : Int){
        productService?.fetchPackageDetail(packageId: packageId)
    }
    func fetchSoftwareSolution(){
        productService?.fetchSoftwareSolution()
    }
}

extension ProductViewModel : ProductServiceDelegate {
    
    func responsePackageDetail(packageId: Int, packageDetails: [PackageDetail]) {
//        print("recieve detail")
//        productViewModelDelegate?.responsePackageDetail(packageDetails: packageDetails)
//        productViewModelDelegate?.responsePackageDetail(packageDetails: packageDetails)
        productViewModelDelegate?.responsePackageDetail(packageDetails: filterPackageDetail(packageId: packageId, packageDetails: packageDetails))
    }
    
    func responseProduct(products : [Product]) {
        productViewModelDelegate?.responseProduct(products: products)
    }
    
    func responsePackage(type : Int, packages : [Package]){
        productViewModelDelegate?.responsePackage(packages: filterPackage(type: type, packages: packages))
    }
    
    func responseSoftwareSolution(solutions: [SoftwareSolution]) {
        productViewModelDelegate?.responseSoftwareSolution(solutions: solutions)
    }
    
    func filterPackage(type : Int, packages : [Package]) -> [Package]{
        var filter = [Package]()
        for package in packages {
            if package.productId == type {
                filter.append(package)
            }
        }
        return filter
    }
    
    func filterPackageDetail(packageId: Int, packageDetails: [PackageDetail]) -> [PackageDetail] {
        var filter = [PackageDetail]()
        for detail in packageDetails {
            if detail.packageId == packageId {
                detail.setDetailEn(str: String((detail.detailEn).dropFirst()))
                detail.setDetailEn(str: (detail.detailEn).replacingOccurrences(of: "▒", with: "\n\n"))
                detail.setDetailKh(str: String((detail.detailKh).dropFirst()))
                
                detail.setDetailKh(str: (detail.detailKh).replacingOccurrences(of: "&amp;", with: "&"))
                detail.setDetailKh(str: (detail.detailKh).replacingOccurrences(of: "\r\n", with: ""))
                detail.setDetailKh(str: (detail.detailKh).replacingOccurrences(of: "▒", with: "\n\n"))
                detail.setDetailKh(str: (detail.detailKh).replacingOccurrences(of: "&nbsp;", with: ""))
                
//                print(detail.detailEn)
                filter.append(detail)
            }
        }
        return filter
    }
    
//    func convertString(str : String) -> String {
//
//    }
}
