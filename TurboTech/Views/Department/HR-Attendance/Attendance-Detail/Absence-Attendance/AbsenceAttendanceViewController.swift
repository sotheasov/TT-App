//
//  AbsenceAttendanceViewController.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/10/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class AbsenceAttendanceViewController: UIViewController {
    
    // IBOutlet of AbsenceAttendanceViewController
    @IBOutlet weak var lbHeaderAbsenceAttendanceOutlet: UILabel!
    @IBOutlet weak var absenceOverallAttendanceTableViewOutlet: UITableView!
    @IBOutlet weak var btnBackAbsenceAttendanceOutlet: UIButton!
    @IBOutlet weak var absenceAttendanceSegmentedOutlet: UISegmentedControl!
    @IBOutlet weak var absenceAttendanceTableViewOutlet: UITableView!
    
    // Declare Variable
    var absenceList = [AbsenceAttendance]()
    var overallList = [AttendanceProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Call Function
        registerTableViewCell()
        customAbsenceAttendanceViewController()
        absenceAttendanceSegmented(absenceAttendanceSegmentedOutlet)
        addGestureSwapeToSegment()
    }
    
    func registerTableViewCell() {
        absenceAttendanceTableViewOutlet.tableFooterView = UIView()
        absenceAttendanceTableViewOutlet.register(UINib(nibName: "AbsenceAttendanceTableViewCell", bundle: nil), forCellReuseIdentifier: "absenceAttendanceCellItem")
        absenceOverallAttendanceTableViewOutlet.register(UINib(nibName: "OverallAttendanceTableViewCell", bundle: nil), forCellReuseIdentifier: "overallAttendanceCellItem")
        absenceOverallAttendanceTableViewOutlet.register(UINib(nibName: "OverallTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "overallHeader")
        absenceAttendanceTableViewOutlet.register(UINib(nibName: "TodayTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "todayHeader")
        absenceAttendanceTableViewOutlet.delegate = self
        absenceAttendanceTableViewOutlet.dataSource = self
        absenceOverallAttendanceTableViewOutlet.delegate = self
        absenceOverallAttendanceTableViewOutlet.dataSource = self
    }
    
    func addGestureSwapeToSegment() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwiped(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwiped(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func handleSwiped(_ sender : UISwipeGestureRecognizer){
        if sender.direction == .right {
            if absenceAttendanceSegmentedOutlet.selectedSegmentIndex == 0 {
                absenceAttendanceSegmentedOutlet.selectedSegmentIndex = 0
            }
            else{
                absenceAttendanceSegmentedOutlet.selectedSegmentIndex -= 1
            }
        }
        else{
            if absenceAttendanceSegmentedOutlet.selectedSegmentIndex == 1 {
                absenceAttendanceSegmentedOutlet.selectedSegmentIndex = 1
            }
            else{
                absenceAttendanceSegmentedOutlet.selectedSegmentIndex += 1
            }
        }
        absenceAttendanceSegmented(absenceAttendanceSegmentedOutlet)
    }
    
    func customAbsenceAttendanceViewController() {
        lbHeaderAbsenceAttendanceOutlet.textColor = COLOR.COLOR_ABSENCE
        
        btnBackAbsenceAttendanceOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 3), opacity: 0.8)
        
        absenceAttendanceSegmentedOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 0.5), opacity: 0.6)
    }
    
    // Action Button
    @IBAction func btnBackAbsenceAttendance(_ sender: UIButton) {
        sender.pulsate()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func absenceAttendanceSegmented(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.absenceAttendanceTableViewOutlet.isHidden = false
            self.absenceOverallAttendanceTableViewOutlet.isHidden = true
            view.backgroundColor = COLOR.WHITE
            break
        default:
            self.absenceAttendanceTableViewOutlet.isHidden = true
            self.absenceOverallAttendanceTableViewOutlet.isHidden = false
            view.backgroundColor = COLOR.WHITE
        }
    }
}

extension AbsenceAttendanceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == absenceAttendanceTableViewOutlet {
            return absenceList.count
        } else if tableView == absenceOverallAttendanceTableViewOutlet {
            return overallList.count
        }
        else {
            return 0
        }
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return ("Morning")
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         if tableView == absenceAttendanceTableViewOutlet {
             let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "todayHeader") as! TodayTableViewHeader
             header.setData(date: "Morning", statusNumber: "Present: 168")
             return header
         }
         else {
             let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "overallHeader") as! OverallTableViewHeader
             return header
         }
     }
     
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 68
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == absenceAttendanceTableViewOutlet,
            let cell = tableView.dequeueReusableCell(withIdentifier: "absenceAttendanceCellItem") as? AbsenceAttendanceTableViewCell {
            cell.selectionStyle = .none
            cell.setData(absenceList[indexPath.row])
            return cell
        }
        else if tableView == absenceOverallAttendanceTableViewOutlet,
            let cell = tableView.dequeueReusableCell(withIdentifier: "overallAttendanceCellItem") as? OverallAttendanceTableViewCell {
            cell.selectionStyle = .none
            cell.setData(overallList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
