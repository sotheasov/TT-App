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
    
    func postRegisterPackageCRM (registerPackageCRM crm : RegisterPackageCRM, completion : @escaping(_ code : Int, _ packageList : String)->()){
        crmService.postRegisterPackageCRM(registerPackageCRM: crm) { (code) in
            if code == 200 {
                completion(code, "register successfully".localized)
            } else {
                completion(code, "please try again !".localized)
            }
        }
    }
}
