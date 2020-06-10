//
//  AttandanceService.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/9/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AttandanceService {
    
    func fetchPresentAttandance(date : String, _ complentionHandler : @escaping(_ presents : [PresentAttendance])->()){
        AF.request(APIManager.ATTENDANCE.GET_CHECKIN + date, method: .get).response { (response) in
            var presents = [PresentAttendance]()
            guard let data = response.data else { return }
            if let jsons = try? JSON(data: data){
                for json in jsons["result"].arrayValue {
                    let pre = PresentAttendance(json: json)
                    presents.append(pre)
                }
            }
            complentionHandler(presents)
        }
    }
    
    func fetchAbsneceAttandance(date : String, _ complentionHandler : @escaping(_ absences : [AbsenceAttendance])->()){
        AF.request(APIManager.ATTENDANCE.GET_ABSENCE + date, method: .get).response { (response) in
            var absences = [AbsenceAttendance]()
            guard let data = response.data else { return }
            if let jsons = try? JSON(data: data){
                for json in jsons["result"].arrayValue {
                    let pre = AbsenceAttendance(json: json)
                    absences.append(pre)
                }
            }
            complentionHandler(absences)
        }
    }
    
    func fetchLateAttandance(date : String, _ complentionHandler : @escaping(_ presents : [PresentAttendance])->()){
        AF.request(APIManager.ATTENDANCE.GET_LATE + date, method: .get).response { (response) in
            var presents = [PresentAttendance]()
            guard let data = response.data else { return }
            if let jsons = try? JSON(data: data){
                for json in jsons["result"].arrayValue {
                    let pre = PresentAttendance(json: json)
                    presents.append(pre)
                }
            }
            complentionHandler(presents)
        }
    }
    
    func fetchPresentForOverall(date : String, _ complentionHandler : @escaping(_ presents : [PresentAttendance])->()){
        AF.request(APIManager.ATTENDANCE.GET_CHECKIN + date, method: .get).response { (response) in
            var presents = [PresentAttendance]()
            guard let data = response.data else { return }
            if let jsons = try? JSON(data: data){
                for json in jsons["result"].arrayValue {
                    let pre = PresentAttendance(json: json, isLate: false)
                    presents.append(pre)
                }
            }
            complentionHandler(presents)
        }
    }
    
    func fetchLateForOverall(date : String, _ complentionHandler : @escaping(_ presents : [PresentAttendance])->()){
        AF.request(APIManager.ATTENDANCE.GET_LATE + date, method: .get).response { (response) in
            var presents = [PresentAttendance]()
            guard let data = response.data else { return }
            if let jsons = try? JSON(data: data){
                for json in jsons["result"].arrayValue {
                    let pre = PresentAttendance(json: json, isLate: true)
                    presents.append(pre)
                }
            }
            complentionHandler(presents)
        }
    }
    
}
