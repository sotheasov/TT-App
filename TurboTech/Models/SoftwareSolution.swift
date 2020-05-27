//
//  SoftwareSolution.swift
//  TurboTech
//
//  Created by sq on 5/25/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import SwiftyJSON

class SoftwareSolution {
    var id : Int
    var nameEn : String
    var nameKh : String
    var detailEn : String
    var detailKh : String
    var imageUrl : String
    var imageWebUrl : String
    
    init(json : JSON){
        self.id = json["id"].intValue
        self.nameEn = json["name en"].stringValue
        self.nameKh = json["name kh"].stringValue
        self.detailEn = json["detail en"].stringValue
        self.detailKh = json["detail kh"].stringValue
        self.imageUrl = APIManager.IMAGE_URL + json["image"].stringValue
        self.imageWebUrl = APIManager.IMAGE_WEB_URL + json["image_web"].stringValue
    }
    init(){
        self.id = 11
        self.detailEn = "hhh"
        self.detailKh = "ហហហ"
        self.nameEn = "ABC"
        self.nameKh = ""
        self.imageUrl = ""
        self.imageWebUrl = ""
    }
}

/*
 "id": 1,
 "name en": "Web Application",
 "name kh": "Web Application",
 "detail en": "We Develop For You Complete Web Projects,​From ​Create To Web Hosting. We Will Create Software That Turns Your Product That Gives You A Advantage​ And Competitive​ . We Have A Clear Understanding Of The Development Requirements, And We Have The Knowledge, Skills, And Experience To Successfully Complete The Projec. Our Full-Stack Developers Are Well-Versed In HTML5, PHP, Laravel, Python, WordPress,​ Java.",
 "detail kh": "យើងនិងអភិវឌ្ឍកម្មវិធី​វេបសាយសំរាប់អ្នកដោយពេញលេញ ចាប់ពីការបង្កើត ដល់ បង្ហោះគេហទំព័រ ។ យើងនឹងបង្កើតកម្មវិធីដែលប្រែក្លាយផលិតផលរបស់អ្នកឱ្យមានអត្ថប្រយោជន៍និងការប្រកួតប្រជែង។ យើងមានការយល់ដឹងច្បាស់អំពីតម្រូវការអភិវឌ្ឍន៍ ហើយយើងក៏មានចំណេះដឹងជំនាញនិងបទពិសោធន៏ដើម្បីបំពេញនូវគំរោងមួយនេះឲ្យបានជោគជ័យ ។ អ្នកអភិវឌ្ឍន៍របស់យើងពោពេញដោយចំនេះដឺងគឺពូកែខាង HTML5, PHP, Laravel, Python, WordPress,​ Java ៕",
 "image": "15900444801355968.png",
 "image_web": "web.jpg"
 */
