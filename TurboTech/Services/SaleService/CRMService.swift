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
    
    func postRegisterPackageCRM (registerPackageCRM crm : RegisterPackageCRM, completion : @escaping(_ statusCode : Int)->()){
        let parameters = [
            "staff_name": "\(crm.userName ?? "monyoudom.bun")",
            "fname": "\(crm.fname ?? "")",
            "lname": "\(crm.lname ?? "")",
            "phone": "\(crm.phone ?? "")",
            "package": "\(crm.packageId ?? "")",
            "village": "\(crm.villageId ?? "")",
            "email": "\(crm.email ?? "")",
            "latlong": "\(crm.latlong ?? "")",
            "address": "\(crm.homeNStreetN ?? "")"
        ]
        AF.request(APIManager.CRM.POST_REGISTER_PACKAGE, method: .post , parameters: parameters).response { (response) in
            guard let data = response.data else { return }
            let json = try? JSON(data: data)
            if let json = json {
                if json["STATUS"].intValue == 200 {
                    completion(json["STATUS"].intValue)
                } else if json["MESSAGE"].stringValue == "invalid request" {
                    completion(0)
                }
            } else {
                completion(-1)
            }
            
        }
    }
}
