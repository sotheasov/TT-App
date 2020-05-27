//
//  HelpDeskViewModel.swift
//  TurboTech
//
//  Created by sq on 5/26/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation

class HelpDeskViewModel {
    var helpDeskService = HelpDeskService()
    
    func postComplainMessage(complain : UserComplain, handler : @escaping(_ message : String)->()){
        helpDeskService.postComplainMessage(complain: complain) { (message) in
            if message == "Data Inserted Successfully" {
                handler("Thanks For Your Us Report Problem")
            }
            
        }
    }
    
    func fetchAllFAQs(handler : @escaping(_ FAQsList : [SupportQuestion])->()){
        helpDeskService.fetchAllFAQs { (list) in
            handler(list)
        }
    }
    
//    deinit {
//        print("Help Desk View Model Deinit")
//    }
}
