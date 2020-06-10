//
//  InsideAttendanceViewController.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/4/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

// MARK: - Complete header view, overall cell, late controller view.

class InsideAttendanceViewController: UIViewController {
    
    // IBOutlet of InsideAttendanceViewController
    @IBOutlet weak var insideAttendanceTableViewOutlet: UITableView!
    @IBOutlet weak var segmentedInsideAttendanceOutlet: UISegmentedControl!
    @IBOutlet weak var btnBackInsideAttendanceOutlet: UIButton!
    
    // Declar variable
    var presentData = [AttendanceProtocol]()
    var overallData = [AttendanceProtocol]()
//    var absenceData = [AttendanceProtocol]()
    
    var isFirstSelected = true
    var presentationType : ATTANDANCE_TYPE?
    
    let attandanceViewModel = AttandanceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call Function
        customInsideAttendanceViewController()
//        segmentInsideAttendance(segmentInsideAttendanceOutlet)
        registerTableViewCell()
        
        // MARK: - FIND NOW() -> Date()
        /*
        DispatchQueue.main.async {
            switch self.presentationType {
                case .present :
                    self.attandanceViewModel.fetchPresentAttandance(date: "2020-06-01") { (data) in
                        self.presentData = data
                        self.insideAttendanceTableViewOutlet.reloadData()
                        print("PRESENT DATA : ", data.count)
                    }
                case .late  :
                    self.attandanceViewModel.fetchLateAttandance(date: "2020-06-01") { (lateList) in
                        self.presentData = lateList
                        self.insideAttendanceTableViewOutlet.reloadData()
                        print("LATE DATA : ", lateList.count)
                    }
                case .absence :
                    print("Absence")
                    self.attandanceViewModel.fetchAbsneceAttandance(date: "2020-06-01")  { (absenceList) in
                        self.presentData = absenceList
                        self.insideAttendanceTableViewOutlet.reloadData()
                        print("ABSENCE DATA : ", absenceList.count)
                    }
                case .none:
                    print("NONE")
            }
            
            // MARK: - Get current date
            // MARK: - Overall, user can change date on screen -> get date after change and fetch data,
            
            self.attandanceViewModel.fectchOverall(date: "2020-06-01") { (list) in
                self.overallData = list
                self.insideAttendanceTableViewOutlet.reloadData()
                print("OVERALL", list.count)
            }
               
        }
        */
    }
    
    func registerTableViewCell() {
        insideAttendanceTableViewOutlet.tableFooterView = UIView()
        insideAttendanceTableViewOutlet.register(UINib(nibName: "InsideAttendanceTableViewCell", bundle: nil), forCellReuseIdentifier: "insideAttendanceCellItem")
        insideAttendanceTableViewOutlet.register(UINib(nibName: "InsideAttendanceOverallTableViewCell", bundle: nil), forCellReuseIdentifier: "InsideAttendanceOverallCellItem")
        insideAttendanceTableViewOutlet.delegate = self
        insideAttendanceTableViewOutlet.dataSource = self
    }
    
    // Action Button
    @IBAction func btnBackInsideAttendance(_ sender: UIButton) {
        sender.pulsate()
        self.dismiss(animated: true, completion: nil)
    }
//    @IBAction func segmentedInsideAttendance(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//            case 0:
//                view.backgroundColor = COLOR.WHITE
//                break
//            default:
//                view.backgroundColor = COLOR.COLOR_ABSENCE
//            }
//    }
    
    func createSegmentedControl() {
        let items = [""]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(segmentedInsideAttendance(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
     }
        
    @objc func segmentedInsideAttendance(_ segmentedControl: UISegmentedControl){
        
        switch segmentedControl.selectedSegmentIndex {
            case 0:
//            self.segmentedInsideAttendanceOutlet.setEnabled(false, forSegmentAt: 1)
                print("FIRST SELECTED")
                view.backgroundColor = COLOR.WHITE
                self.isFirstSelected = true
                self.insideAttendanceTableViewOutlet.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
//                self.insideAttendanceTableViewOutlet.reloadData()
            case 1:
//                self.segmentedInsideAttendanceOutlet.setEnabled(false, forSegmentAt: 0)
                print("SECOND SELECTED")
                self.isFirstSelected = false
                self.insideAttendanceTableViewOutlet.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
//                self.insideAttendanceTableViewOutlet.reloadData()
            default:
                view.backgroundColor = COLOR.WHITE_SMOKE_GREY
            }
        self.insideAttendanceTableViewOutlet.reloadData()
    }
    
    func customInsideAttendanceViewController() {
        btnBackInsideAttendanceOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 3), opacity: 0.8)
        
        segmentedInsideAttendanceOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 0.5), opacity: 0.6)
    }
    
}

extension InsideAttendanceViewController: UITableViewDelegate, UITableViewDataSource{    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("ROW : ", presentData.count)
        if isFirstSelected {
            print(" ---------> first")
            return presentData.count
        }
        else {
            print(" ---------> second")
            return overallData.count
        }
//        return isFirstSelected ? presentData.count : overallData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        isFirstSelected ? "Today" : "Overall"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("TT : ", insideAttendanceTableViewOutlet.coun)
        if isFirstSelected {
            // return cell first
            let cell = tableView.dequeueReusableCell(withIdentifier: "insideAttendanceCellItem") as! InsideAttendanceTableViewCell
            cell.selectionStyle = .none
            print("CELL : ", presentData.count)
            for pData in presentData {
                print(pData.name)
            }
            cell.setData(attandnce: presentData[indexPath.row])
            switch presentationType {
                case .present:
                    cell.isPresentView()
                case .late:
                    cell.isLateView()
                case .absence:
                    cell.isAbsenceView()
                case .none:
                    print("NONE")
            }

//            self.segmentedInsideAttendanceOutlet.setEnabled(true, forSegmentAt: 1)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InsideAttendanceOverallCellItem") as! InsideAttendanceOverallTableViewCell
            cell.selectionStyle = .none
            cell.setData(attandnce: overallData[indexPath.row])

//            self.segmentedInsideAttendanceOutlet.setEnabled(true, forSegmentAt: 0)
            return cell
        }
    }
    
    
}
