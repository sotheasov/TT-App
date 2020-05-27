//
//  HelpDesk.swift
//  TurboTech
//
//  Created by sq on 5/26/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserComplain {
    var type : String
    var question : String
    
    init(type : String, question : String){
        self.type = type
        self.question = question
    }
    
    func setType(type : String){
        self.type = type
    }
    
    func setQuestion(question : String) {
        self.question = question
    }
}
