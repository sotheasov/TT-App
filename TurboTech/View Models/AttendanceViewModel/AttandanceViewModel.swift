//
//  AttandanceViewModel.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/9/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation

class AttandanceViewModel {
    
    let attandanceService = AttandanceService()
    
    func fetchPresentAttandance(date : String, _ complentionHandler : @escaping(_ presents : [PresentAttendance])->()){
        attandanceService.fetchPresentAttandance(date: date) { (list) in
            complentionHandler(list)
        }
    }
    
    func fetchAbsneceAttandance(date : String, _ complentionHandler : @escaping(_ absences : [AbsenceAttendance])->()){
        attandanceService.fetchAbsneceAttandance(date: date) { (list) in
            complentionHandler(list)
        }
    }
    
    func fetchLateAttandance(date : String, _ complentionHandler : @escaping(_ presents : [PresentAttendance])->()){
        attandanceService.fetchLateAttandance(date: date) { (list) in
            complentionHandler(list)
        }
    }
    
    func fectchOverall(date : String, _ complentionHandler : @escaping(_ overall: [AttendanceProtocol])->())  {
        var list = [AttendanceProtocol]()
        self.attandanceService.fetchLateForOverall(date: date) { (lateList) in
            list.append(contentsOf: lateList)
            self.attandanceService.fetchAbsneceAttandance(date: date) { (absenceList) in
                list.append(contentsOf: absenceList)
                self.attandanceService.fetchPresentForOverall(date: date) { (attandanceList) in
                    list.append(contentsOf: attandanceList)
                    complentionHandler(list)
                }
            }
        }
    }
    
}
