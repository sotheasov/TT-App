//
//  SaleService.swift
//  TurboTech
//
//  Created by sq on 5/26/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SaleService {
    
    let headers : HTTPHeaders = APIManager.HEADER
    
    func fetchAllPop(handler : @escaping(_ FAQsList : [POP])->()){
        var popList = [POP]()
        AF.request("\(APIManager.SALE.GET_POP)", method: .get, headers: headers).response { (response) in
            guard let data = response.data else { return }
            if let jsons = try? JSON(data: data){
                for json in jsons["result"].arrayValue {
                    let pop = POP(json: json)
                    popList.append(pop)
                }
            }
            handler(popList)
        }
    }
    
    func fetchDevices(completionHandler : @escaping(_ deviceList : [Device])->()){
        var devices = [Device]()
        AF.request("\(APIManager.SALE.GET_DEVICE)", method: .get, headers: headers).response { (response) in
            guard let data = response.data else { return }
            if let jsons = try? JSON(data: data){
                for json in jsons["result"].arrayValue {
                    let device = Device(json: json)
                    devices.append(device)
                }
            }
            completionHandler(devices)
        }
    }
    
    func fetchAddress(addressType : ADDRESS, id : String?, completionHandler : @escaping(_ addresList : [Address])->()){
        var url : String = ""
        switch addressType {
        case .province :
            url = APIManager.ADDRESS.PROVINCE
        case .district :
            url = APIManager.ADDRESS.DISTRICT + "\(id ?? "")"
        case .commune :
            url = APIManager.ADDRESS.COMMUNE + "\(id ?? "")"
        case .village :
            url = APIManager.ADDRESS.VILLAGE + "\(id ?? "")"
        }
        var addrList = [Address]()
        print(url)
        AF.request(url, method: .get, headers: headers).response{(response)in
            guard let data = response.data else {return}
            if let jsons = try? JSON(data: data){
                for json in jsons["result"].arrayValue {
                    let addr = Address(json: json)
                    addrList.append(addr)
                }
            }
            completionHandler(addrList)
        }
    }
    
}
