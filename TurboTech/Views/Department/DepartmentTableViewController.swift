//
//  DepartmentTableViewController.swift
//  TurboTech
//
//  Created by sq on 5/27/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class DepartmentTableViewController: UITableViewController {
    
    var departmentList = [Department]()
    var openType : Position?
    var preType : Position?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        tableView.register(UINib(nibName: "SubMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SubMenuCellID")
    }
    
    func setOpenType(position : Position){
        self.openType = position
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setDepartment()
    }
    
    func setDepartment() {
        /*
        let str = "https://www.turbotech.com/storages/assets/img/img_mobile/15900490041355968.png"
        departmentList = [Department]()
        switch openType {
            case .Admin :
                print("Here Admin")
                departmentList.append(Department(id: 0, name: "Sale", image: str, position: .Sale))
                departmentList.append(Department(id: 1, name: "Finance", image: str, position: .Finance))
                departmentList.append(Department(id: 2, name: "Attendance", image: str, position: .HR))
            case .Sale :
                print("Here Sale")
                departmentList.append(Department(id: 0, name: "Product", image: str, position: .Product))
                departmentList.append(Department(id: 1, name: "POP", image: str, position: .Pop))
                departmentList.append(Department(id: 2, name: "Device", image: str, position: .Device))
                departmentList.append(Department(id: 3, name: "CRM", image: str, position: .CRM))
            case .HR :
                print("Here HR")
            case .Finance  :
                print("Here Finance")
            case .Product :
                print("Here Product")
                let productStoryboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
                let productVC = productStoryboard.instantiateViewController(withIdentifier: "ProductViewControllerID") as! ProductViewController
                productVC.modalPresentationStyle = .fullScreen
                productVC.setNavigationTitle(title: "Product")
                productVC.setTypeId(id: 0)
                productVC.position = .Sale
                self.navigationController?.pushViewController(productVC, animated: true)
            case .Pop  :
                print("Here Pop")
            case .Device :
                print("Here Device")
            case .CRM  :
                print("Here CRM")
            case .Payment :
                print("Here Payment")
            case .Chart  :
                print("Here Chart")
            case .none:
                print("Hey you eng love me man?")
            }
        
        self.tableView.reloadData()
 */
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departmentList.count
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
    
    func pushVC(indexPath : IndexPath){
//        let openVC = storyboard?.instantiateViewController(identifier: "DepartmentTableViewControllerID") as! DepartmentTableViewController
//        openVC.setOpenType(position: departmentList[indexPath.row].sale)
//        openVC.navigationItem.title = departmentList[indexPath.row].name
//        self.navigationController?.pushViewController(openVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.preType = self.openType
        self.openType = departmentList[indexPath.row].position
        pushVC(indexPath: indexPath)
    }
}

extension DepartmentTableViewController : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        print("Delegate : ", openType)
        (viewController as? DepartmentTableViewController)?.setOpenType(position: self.openType!)// Here you pass the to your original view controller
    }
    
    override func willMove(toParent parent: UIViewController?) {
//        print("Delegate move: ", openType)
        (parent as? DepartmentTableViewController)?.setOpenType(position: self.openType!)
    }
}
