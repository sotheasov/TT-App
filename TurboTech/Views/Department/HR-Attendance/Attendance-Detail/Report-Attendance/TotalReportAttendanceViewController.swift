//
//  TotalReportAttendanceViewController.swift
//  TurboTech
//
//  Created by Unknown on 6/17/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class TotalReportAttendanceViewController: UIViewController {
    @IBOutlet weak var lbHeaderTotalReportAttendanceOutlet: UILabel!
    @IBOutlet weak var totalReportAttendanceTableViewOutlet: UITableView!
    @IBOutlet weak var btnBackTotalReportAttendanceOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableViewCell()
        customTotalReportAttendanceViewController()
        
    }
    
    func registerTableViewCell() {
        totalReportAttendanceTableViewOutlet.tableFooterView = UIView()
        totalReportAttendanceTableViewOutlet.register(UINib(nibName: "LateReportAttendanceTableViewCell", bundle: nil), forCellReuseIdentifier: "lateReportAttendanceCellItem")
        totalReportAttendanceTableViewOutlet.delegate = self
        totalReportAttendanceTableViewOutlet.dataSource = self
    }
    
    func customTotalReportAttendanceViewController() {
        lbHeaderTotalReportAttendanceOutlet.textColor = COLOR.COLOR_PRESENT
    }

    @IBAction func btnBackTotalReportAttendance(_ sender: UIButton) {
        sender.pulsate()
        self.dismiss(animated: true, completion: nil)
    }
}
extension TotalReportAttendanceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lateReportAttendanceCellItem") as! LateReportAttendanceTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    
}
