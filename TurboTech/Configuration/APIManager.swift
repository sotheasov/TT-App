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
    static let IMAGE_WEB_URL = "https://www.turbotech.com/storages/assets/img/services/"
    static let HEADER : HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    enum SW_SOLUTION {
        // res {id, name en, name kh, image}
        static let GET = MAIN_URL + "/api/software_solution/"
    }
    
    enum SALE {
        static let GET_POP = MAIN_URL + "/sale/POP"
        static let GET_DEVICE = MAIN_URL + "/sale/productlist/"
    }
    
    enum LOGIN {
        // param {username:varchar, password:varchar}
        // form {ID Card, Full Name, Position, User Name}
        static let POST = MAIN_URL + "/login/index.php"
    }
    
    enum HELP_DESK {
        // param {idcard, code, protypename, question}
        static let POST = MAIN_URL + "/help_dest/addproblem.php"
        static let GET_PROBLEM = MAIN_URL + "/help desk/readproblemtype.php"
        static let GET = MAIN_URL + "/support/"
    }
    
    enum PACKAGE {
        static let GET = MAIN_URL + "/package/"
        static let GET_DETAIL = MAIN_URL + "/package_detail"
        static let GET_SOFTWARE_SOLUTIOLN = MAIN_URL + "/software_solution/"
    }
    
    enum PRODUCT {
        static let GET = MAIN_URL + "/service"
    }
}

