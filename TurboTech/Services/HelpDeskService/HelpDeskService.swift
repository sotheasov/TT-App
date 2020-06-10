//
//  HelpDeskService.swift
//  TurboTech
//
//  Created by sq on 5/26/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HelpDeskService{
    
    let headers : HTTPHeaders = APIManager.HEADER
    
    func postComplainMessage(complain : UserComplain, handler : @escaping(_ message : String)->()){
//        print(complain.type)
        
        let params = [
            "protypename" : complain.type,
            "question" : complain.question
        ]
        
        var message = ""
        
        AF.request(APIManager.HELP_DESK.POST, method: .post, parameters: params, encoding: URLEncoding.default).response { (response) in
            guard let data = response.data else { return }
            if let json = try? JSON(data: data){
                message = json["message"].string ?? "NO POST"
//                print("My message : ", message)
                if message == "NO ID" {
                    self.defaultPostComplain(complain: complain) { (msg) in
                        message = msg
                    }
                }
            }
            handler(message)
        }
    }
    
    private func defaultPostComplain(complain : UserComplain, handler : (_ message : String)->()){
        
        let params = ["protypename" : "Internet", "question" : complain.question]
        var message = ""
        AF.request(APIManager.HELP_DESK.POST, method: .post, parameters: params, headers: headers).response { (response) in
            guard let data = response.data else { return }
            if let json = try? JSON(data: data){
                message = json["message"].stringValue
//                print(message)
            }
        }
        handler(message)
    }
    
    func fetchAllFAQs(handler : @escaping(_ FAQsList : [SupportQuestion])->()){
        var FAQsList = [SupportQuestion]()
        AF.request("\(APIManager.HELP_DESK.GET)", method: .get, headers: headers).response { (response) in
            guard let data = response.data else { return }
            if let jsons = try? JSON(data: data){
                for json in jsons["result"].arrayValue {
                    let sq = SupportQuestion(json: json)
//                    print(sq.id)
                    FAQsList.append(sq)
                }
            }
            handler(FAQsList)
        }
    }
}
