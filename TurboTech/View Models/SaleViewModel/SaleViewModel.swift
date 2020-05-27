//
//  SaleViewModel.swift
//  TurboTech
//
//  Created by sq on 5/26/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation

class SaleViewModel {
    
    let saleService = SaleService()
    
    func fetchAllPop(handler : @escaping(_ FAQsList : [POP])->()){
        saleService.fetchAllPop { (popList) in
            print("service model = ", popList.count)
            handler(popList)
        }
    }
}