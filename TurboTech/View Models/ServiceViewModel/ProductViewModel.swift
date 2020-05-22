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
}

extension ProductViewModel : ProductServiceDelegate {
    func responseProduct(products : [Product]) {
        productViewModelDelegate?.responseProduct(products: products)
    }
    
    func responsePackage(type : Int, packages : [Package]){
        productViewModelDelegate?.responsePackage(packages: filterPackage(type: type, packages: packages))
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
}
