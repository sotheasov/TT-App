//
//  AdminTableViewController.swift
//  TurboTech
//
//  Created by sq on 5/27/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class AdminTableViewController: UITableViewController {
    
    var departmentList = [Department]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        tableView.register(UINib(nibName: "SubMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SubMenuCellID")
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "launchScreen")!)
    }
    
    func setData() {
        let str = "https://www.turbotech.com/storages/assets/img/img_mobile/15900490041355968.png"
        print("Here Admin")
        departmentList.append(Department(id: 0, name: "Sale", image: str, position: .Sale))
        departmentList.append(Department(id: 1, name: "Finance", image: str, position: .Finance))
        departmentList.append(Department(id: 2, name: "Attendance", image: str, position: .HR))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        departmentList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubMenuCellID") as! SubMenuTableViewCell
        cell.setData(department: departmentList[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.size.height
        if (height < 600){
            return height / SIZE.NUM_ROW_PRO_SMALL
        }
        else if (height < 800) {
            return height / SIZE.NUM_ROW_PRO_MEDIUM
        }
        else {
            return height / SIZE.NUM_ROW_PRO_LARGE
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let openVC = storyboard?.instantiateViewController(identifier: "") as! DepartmentTableViewController
//        openVC.setOpenType(position: departmentList[indexPath.row].position)
//        openVC.navigationItem.title = departmentList[indexPath.row].name
//        self.navigationController?.pushViewController(openVC, animated: true)
        switch departmentList[indexPath.row].position! {
        case .Sale :
            let openVC = storyboard?.instantiateViewController(identifier: CONTROLLER.SALE) as! SaleTableViewController
            openVC.navigationItem.title = departmentList[indexPath.row].name
            self.navigationController?.pushViewController(openVC, animated: true)
        case .Finance :
            let openVC = storyboard?.instantiateViewController(identifier: CONTROLLER.SALE) as! SaleTableViewController
            openVC.navigationItem.title = departmentList[indexPath.row].name
            self.navigationController?.pushViewController(openVC, animated: true)
        case  .HR:
            // MARK: - @Sothea Attendance Screen
            print("Attendance")
            let attendanceStoryboard = UIStoryboard(name: BOARD.ABOUTUS, bundle: nil)
            let attendance = attendanceStoryboard.instantiateViewController(withIdentifier: CONTROLLER.ATTENDANCE) as! AttendanceViewController
                self.showDetailViewController(attendance, sender: nil)
//            let openVC = storyboard?.instantiateViewController(identifier: CONTROLLER.SALE) as! SaleTableViewController
//            openVC.navigationItem.title = departmentList[indexPath.row].name
//            self.navigationController?.pushViewController(openVC, animated: true)
        case .Admin:
            print("Owner hz Dear")
        }
    }

}
