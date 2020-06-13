//
//  LateAttendanceViewController.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/10/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class LateAttendanceViewController: UIViewController {
    
    // IBOutlet of LateAttendanceViewController
    @IBOutlet weak var lateAttendanceSegmentedOutlet: UISegmentedControl!
    @IBOutlet weak var btnBackLateAttendanceOutlet: UIButton!
    @IBOutlet weak var lateOverallAttendanceTableViewOutlet: UITableView!
    @IBOutlet weak var lateAttendanceTableViewOutlet: UITableView!
    
    // Declare Variable
    var lateList = [PresentAttendance]()
    var overallList = [AttendanceProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call Function
        registerTableViewCell()
        customLateAttendanceViewController()
        lateAttendanceSegmented(lateAttendanceSegmentedOutlet)
        addGestureSwapeToSegment()
    }
    
    
    func registerTableViewCell() {
        lateAttendanceTableViewOutlet.tableFooterView = UIView()
        lateAttendanceTableViewOutlet.register(UINib(nibName: "LateAttendanceTableViewCell", bundle: nil), forCellReuseIdentifier: "lateAttendanceCellItem")
        lateOverallAttendanceTableViewOutlet.register(UINib(nibName: "OverallAttendanceTableViewCell", bundle: nil), forCellReuseIdentifier: "overallAttendanceCellItem")
        lateOverallAttendanceTableViewOutlet.register(UINib(nibName: "OverallTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "overallHeader")
        lateAttendanceTableViewOutlet.register(UINib(nibName: "TodayTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "todayHeader")
        lateAttendanceTableViewOutlet.delegate = self
        lateAttendanceTableViewOutlet.dataSource = self
        lateOverallAttendanceTableViewOutlet.delegate = self
        lateOverallAttendanceTableViewOutlet.dataSource = self
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
            if lateAttendanceSegmentedOutlet.selectedSegmentIndex == 0 {
                lateAttendanceSegmentedOutlet.selectedSegmentIndex = 0
            }
            else{
                lateAttendanceSegmentedOutlet.selectedSegmentIndex -= 1
            }
        }
        else{
            if lateAttendanceSegmentedOutlet.selectedSegmentIndex == 1 {
                lateAttendanceSegmentedOutlet.selectedSegmentIndex = 1
            }
            else{
                lateAttendanceSegmentedOutlet.selectedSegmentIndex += 1
            }
        }
        lateAttendanceSegmented(lateAttendanceSegmentedOutlet)
    }
    
    func customLateAttendanceViewController() {
        btnBackLateAttendanceOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 3), opacity: 0.8)
        
        lateAttendanceSegmentedOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 0.5), opacity: 0.6)
    }
    
    // Action Button
    @IBAction func btnBackLateAttendance(_ sender: UIButton) {
        sender.pulsate()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func lateAttendanceSegmented(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.lateAttendanceTableViewOutlet.isHidden = false
            self.lateOverallAttendanceTableViewOutlet.isHidden = true
            view.backgroundColor = COLOR.WHITE
            break
        default:
            self.lateAttendanceTableViewOutlet.isHidden = true
            self.lateOverallAttendanceTableViewOutlet.isHidden = false
            view.backgroundColor = COLOR.WHITE
        }
    }
    
}

extension LateAttendanceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == lateAttendanceTableViewOutlet {
            return lateList.count
        } else if tableView == lateOverallAttendanceTableViewOutlet {
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
        if tableView == lateAttendanceTableViewOutlet {
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
        if tableView == lateAttendanceTableViewOutlet,
            let cell = tableView.dequeueReusableCell(withIdentifier: "lateAttendanceCellItem") as? LateAttendanceTableViewCell {
            cell.selectionStyle = .none
            cell.setData(lateList[indexPath.row])
            return cell
        }
        else if tableView == lateOverallAttendanceTableViewOutlet,
            let cell = tableView.dequeueReusableCell(withIdentifier: "overallAttendanceCellItem") as? OverallAttendanceTableViewCell {
            cell.selectionStyle = .none
            cell.setData(overallList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

    
    
    
    
