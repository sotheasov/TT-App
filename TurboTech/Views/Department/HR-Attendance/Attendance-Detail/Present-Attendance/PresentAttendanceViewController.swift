//
//  PresentAttendanceViewController.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/10/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class PresentAttendanceViewController: UIViewController {
    
    // IBOutlet of PresentAttendanceViewController
    @IBOutlet weak var lbHeaderPresentAttendanceOutlet: UILabel!
    @IBOutlet weak var btnBackPresentAttendanceOutlet: UIButton!
    @IBOutlet weak var presentAttendanceSegmentedOutlet: UISegmentedControl!
    @IBOutlet weak var presentOverallAttendanceTableViewOutlet: UITableView!
    @IBOutlet weak var presentAttendanceTableViewOutlet: UITableView!
    
    // Declare Variable
    var presentList = [PresentAttendance]()
    var overallList = [AttendanceProtocol]()
//    let currentTime = OverallTableViewHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call Function
        registerTableViewCell()
        customPresentAttendanceViewController()
        presentAttendanceSegmented(presentAttendanceSegmentedOutlet)
        addGestureSwapeToSegment()
        
    }
    
    func registerTableViewCell() {
        presentAttendanceTableViewOutlet.tableFooterView = UIView()

        presentOverallAttendanceTableViewOutlet.register(UINib(nibName: "OverallAttendanceTableViewCell", bundle: nil), forCellReuseIdentifier: "overallAttendanceCellItem")
        presentOverallAttendanceTableViewOutlet.register(UINib(nibName: "OverallTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "overallHeader")
        
        presentAttendanceTableViewOutlet.register(UINib(nibName: "PresentAttendanceTableViewCell", bundle: nil), forCellReuseIdentifier: "presentAttendanceCellItem")
        presentAttendanceTableViewOutlet.register(UINib(nibName: "TodayTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "todayHeader")
        
        presentAttendanceTableViewOutlet.delegate = self
        presentAttendanceTableViewOutlet.dataSource = self
        presentOverallAttendanceTableViewOutlet.delegate = self
        presentOverallAttendanceTableViewOutlet.dataSource = self
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
            if presentAttendanceSegmentedOutlet.selectedSegmentIndex == 0 {
                presentAttendanceSegmentedOutlet.selectedSegmentIndex = 0
            }
            else{
                presentAttendanceSegmentedOutlet.selectedSegmentIndex -= 1
            }
        }
        else{
            if presentAttendanceSegmentedOutlet.selectedSegmentIndex == 1 {
                presentAttendanceSegmentedOutlet.selectedSegmentIndex = 1
            }
            else{
                presentAttendanceSegmentedOutlet.selectedSegmentIndex += 1
            }
        }
        presentAttendanceSegmented(presentAttendanceSegmentedOutlet)
    }
    
    func customPresentAttendanceViewController() {
        lbHeaderPresentAttendanceOutlet.textColor = COLOR.COLOR_PRESENT
        
        btnBackPresentAttendanceOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 3), opacity: 0.8)
        
        presentAttendanceSegmentedOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 0.5), opacity: 0.6)
    }
    
    // Action Button
    @IBAction func btnBackPresentAttendance(_ sender: UIButton) {
        sender.pulsate()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func presentAttendanceSegmented(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.presentAttendanceTableViewOutlet.isHidden = false
            self.presentOverallAttendanceTableViewOutlet.isHidden = true
            view.backgroundColor = COLOR.WHITE
            break
        default:
            self.presentAttendanceTableViewOutlet.isHidden = true
            self.presentOverallAttendanceTableViewOutlet.isHidden = false
            view.backgroundColor = COLOR.WHITE
        }
    }
}

extension PresentAttendanceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == presentAttendanceTableViewOutlet {
            return presentList.count
        } else if tableView == presentOverallAttendanceTableViewOutlet {
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
        if tableView == presentAttendanceTableViewOutlet {
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
        if tableView == presentAttendanceTableViewOutlet,
            let cell = tableView.dequeueReusableCell(withIdentifier: "presentAttendanceCellItem") as? PresentAttendanceTableViewCell {
            cell.selectionStyle = .none
            cell.setData(presentList[indexPath.row])
            return cell
        }
        else if tableView == presentOverallAttendanceTableViewOutlet,
            let cell = tableView.dequeueReusableCell(withIdentifier: "overallAttendanceCellItem") as? OverallAttendanceTableViewCell {
            cell.selectionStyle = .none
            cell.setData(overallList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
