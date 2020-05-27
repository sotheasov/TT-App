//
//  SupportQuestion.swift
//  TurboTech
//
//  Created by sq on 5/26/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import SwiftyJSON

class SupportQuestion {
    var id : Int
    var questionEn : String
    var questionKh : String
    var answerEn : String
    var answerKh : String
    var date : String
    var isCollapse = true // បិទ
    
    init(json : JSON){
        self.id = json["id"].intValue
        self.questionEn = json["q_en"].stringValue
        self.questionKh = json["q_kh"].stringValue
        self.answerEn = json["a_en"].stringValue
        self.answerKh = json["a_kh"].stringValue
        self.date = json["date"].stringValue
    }
    
    func setQuestion(en : String, kh : String){
        self.questionEn = en
        self.questionKh = kh
    }
    
    func setAnswer(en : String, kh : String){
        self.answerEn = en
        self.answerKh = kh
    }
}
/*
 id": 20,
 "q_en": "What are requirement information for installation Internet?",
 "q_kh": "ដើម្បីតម្លើងអុីនធើណេតតើក្រុមហ៊ុន ធើបូថេក ឯ.​ក ត្រូវការអ្វីខ្លះ?",
 "a_en": "+ For Home ៖\r\n     a) ID Card.\r\n     b) Contact number. \r\n     c) E-mail and Facebook etc… \r\n     d) Address \r\n+ For Company​ ​៖\r\n      a) VAT. \r\n      b) Parten .\r\n      c) Contact number. \r\n      e) E-mail and Facebook etc… \r\n      d) Address ",
 "a_kh": "+ សម្រាប់គេហដ្ឋាន \r\n     ក. លេខទូរសព្ទ \r\n     ខ.​​ អត្តសញ្ញាណប័ណ្ណ \r\n     គ. អុីម៉ែល ឬបណ្តាញសង្គមផ្សេងៗ\r\n     ឃ. ទីតាំង\r\n\r\n+ សម្រាប់ក្រុមហ៊ុន\r\n     ក. លេខទូរសព្ទ \r\n     ខ. ប័ណ្ណប៉ាតង់ក្រុមហ៊ុន\r\n    ​​គ. អុីម៉ែល ឬបណ្តាញសង្គមផ្សេងៗ\r\n     ឃ. ទីតាំង",
 "date": "2020-05-22 14:33:15"
 */
