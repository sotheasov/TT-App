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
    static let MAIN_URL_2 = "http://103.101.80.73"
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
        static let GET_PROBLEM = MAIN_URL + "/help_dest/readproblemtype.php"
//        https://turbotech.com/api/help_dest/readproblemtype.php
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
    
    enum ATTENDANCE {
        static let GET_CHECKIN = MAIN_URL_2 + "/figerprint/api/fingerprint_present.php?today_date=" // 2020-06-01
        static let GET_ABSENCE = MAIN_URL_2 + "/figerprint/api/fingerprint_absent.php?today_date=" //2020-06-01
        static let GET_LATE = MAIN_URL_2 + "/figerprint/api/fingerprint_lates.php?today_date=" //2020-06-01
    enum ADDRESS {
        static let PROVINCE = MAIN_URL + "/key_gazetteers/province.php"
        static let DISTRICT = MAIN_URL + "/key_gazetteers/district.php?province_id="
        static let COMMUNE = MAIN_URL + "/key_gazetteers/commune.php?district_id="
        static let VILLAGE = MAIN_URL + "/key_gazetteers/village.php?commune_id="
    }
    
    enum CRM {
        static let GET_PACKAGE = MAIN_URL + "/register_service/readpackage.php"
        static let POST_REGISTER_PACKAGE = MAIN_URL + "/register_service/register_crm.php"
    }
}

