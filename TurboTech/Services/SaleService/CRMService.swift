//
//  File.swift
//  TurboTech
//
//  Created by sq on 6/10/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class CRMService {
    
    let headers : HTTPHeaders = APIManager.HEADER
    
    func fetchRegisterPackage(completion : @escaping(_ packageList : [CRMPackage])->()){
        var packageList = [CRMPackage]()
        AF.request("\(APIManager.CRM.GET_PACKAGE)", method: .get, headers: headers).response { (response) in
            guard let data = response.data else { return }
            if let jsons = try? JSON(data: data){
                for json in jsons["result"].arrayValue {
                    let package = CRMPackage(json: json)
                    packageList.append(package)
                }
            }
            completion(packageList)
        }
    }
}
