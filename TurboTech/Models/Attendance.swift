//
//  Attendance.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/9/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol AttendanceProtocol {
    var name : String { get }
    var statusName : String { get }
}

class PresentAttendance : AttendanceProtocol {
    var name: String
    var statusName: String
    var time : String
    
    init(json : JSON){
        self.name = json["NAME"].stringValue
        self.time = json["TIME"].stringValue
        self.statusName = json["STATE_NAME"].stringValue
    }
    
    init(json: JSON, isLate : Bool){
        self.name = json["NAME"].stringValue
        self.time = json["TIME"].stringValue
        self.statusName = isLate ? "Late" : "Present"
    }
    
}

class AbsenceAttendance : AttendanceProtocol {
    var name : String
    var statusName : String
    
    init(json : JSON){
        self.name = json["NAME"].stringValue
        self.statusName = "Absent"
    }
    
}

protocol ReportAttendanceProtocol {
    var nameReport : String { get }
    var dateReport : String { get }
}

class FullEarlyReport : ReportAttendanceProtocol {
    var nameReport: String
    var dateReport: String
    
    init(json : JSON){
        self.nameReport = json["name"].stringValue
        self.dateReport = json["date"].stringValue
    }
    
    init(json: JSON, isFullLateReport : Bool){
        self.nameReport = json["name"].stringValue
        self.dateReport = json["date"].stringValue
//        self.statusName = isLate ? "Late" : "Present"
    }
    
}


//enum ATTANDANCE_TYPE {
//    case present
//    case late
//    case absence
//}
