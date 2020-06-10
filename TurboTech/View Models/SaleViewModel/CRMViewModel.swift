//
//  CRMViewModel.swift
//  TurboTech
//
//  Created by sq on 6/10/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation

class CRMViewModel {
    let crmService = CRMService()
    
    func fetchRegisterPackage(completion : @escaping(_ packageList : [CRMPackage])->()){
        crmService.fetchRegisterPackage { (packageList) in
            completion(packageList)
        }
    }
}
