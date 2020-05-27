//
//  APIManager.swift
//  TurboTech
//
//  Created by sq on 5/19/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    static let MAIN_URL = "https://turbotech.com/api"
    static let IMAGE_URL = "https://www.turbotech.com/storages/assets/img/img_mobile/"
    static let HEADER : HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    enum SW_SOLUTION {
        // res {id, name en, name kh, image}
        static let GET = MAIN_URL + "/api/software_solution/"
    }
    
    enum POP {
        static let GET = MAIN_URL + "/sale/POP"
    }
    
    enum LOGIN {
        // param {username:varchar, password:varchar}
        // form {ID Card, Full Name, Position, User Name}
        static let POST = MAIN_URL + "/login/index.php"
    }
    
    enum HELP_DESK {
        // param {idcard, code, protypename, question}
        static let POST = MAIN_URL + "/help desk/addproblem.php"
        static let GET = MAIN_URL + "/help desk/readproblemtype.php"
    }
    
    enum PACKAGE {
        static let GET = MAIN_URL + "/package/"
        static let GET_DETAIL = MAIN_URL + "/package_detail"
    }
    
    enum PRODUCT {
        static let GET = MAIN_URL + "/service"
    }
}

