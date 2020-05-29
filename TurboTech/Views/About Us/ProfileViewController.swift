//
//  AboutUsTableViewController.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/25/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // IBOutlet of ProfileViewController
    @IBOutlet weak var coverProfileImageView: UIView!
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    // Declare Variable
    let data = ["Information", "Department", "Language", "Logout"]
//    let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.tableFooterView = UIView()
        
//        let height = self.view.frame.height
//
//        if height > 800 {
//            self.profileTableView.isScrollEnabled = true
//        } else {
//            self.profileTableView.isScrollEnabled = false
//        }
        
        // Register Profile TableViewCell
        profileTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "profileCellItem")
        
        // Call Function
        customProfileViewController()
    }
    
    func customProfileViewController() {
        coverProfileImageView.layer.cornerRadius = 10
        coverProfileImageView.shadowStyle(radius: 8, color: .black, offset: CGSize(width: 0, height: 10), opacity: 0.8)
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.layer.borderWidth = 5
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
            4
    }
        
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        print("Section : ", section)
    //        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
    //        label.text = "\(data[section])"
    //        return label
    //    }
        
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            data[section]
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        else {
            return 1
        }
            //        return data.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCellItem") as! ProfileTableViewCell
    //        if (indexPath.section == 0 ){
                cell.selectionStyle = .none
    //        }
    //        if indexPath.row % 2 == 0 {
    //            cell = tableView.dequeueReusableCell(withIdentifier: "profileCellItem") as! ProfileTableViewCell
    //        }
    //        cell?.textLabel?.text = data[indexPath.row]
            return cell
            
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        switch section {
        case 1:
            print("Department")
            //Another Way to Call Other Storyboard
//        let homeStoryboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
//        let productVC = homeStoryboard.instantiateViewController(withIdentifier: "ProductViewControllerID") as! ProductViewController
//            productVC.setNavigationTitle(title: "Product")
//            self.navigationController?.pushViewController(productVC, animated: true)
//        let department = storyboard?.instantiateViewController(withIdentifier: "DepartmentViewControllerID") as! DepartmentViewController
//        self.navigationController?.pushViewController(department, animated: true)
            
            // MARK: - Seakthong
            switch AppDelegate.position {
            case .Admin :
                let departmentStoryboard = UIStoryboard(name: BOARD.DEPARTMENT, bundle: nil)
                let openVC = departmentStoryboard.instantiateViewController(withIdentifier: CONTROLLER.ADMIN) as! AdminTableViewController
                openVC.navigationItem.title = "ADMIN"
                self.navigationController?.pushViewController(openVC, animated: true)
            case .Finance :
                let departmentStoryboard = UIStoryboard(name: BOARD.DEPARTMENT, bundle: nil)
                let openVC = departmentStoryboard.instantiateViewController(withIdentifier: CONTROLLER.FINANCE) as! FinanceTableViewController
                openVC.navigationItem.title = "Finance"
                self.navigationController?.pushViewController(openVC, animated: true)
            case .HR :
                let departmentStoryboard = UIStoryboard(name: BOARD.DEPARTMENT, bundle: nil)
                let openVC = departmentStoryboard.instantiateViewController(withIdentifier: CONTROLLER.ADMIN) as! AdminTableViewController
                openVC.navigationItem.title = "HR"
                self.navigationController?.pushViewController(openVC, animated: true)
            case .Sale :
                let departmentStoryboard = UIStoryboard(name: BOARD.DEPARTMENT, bundle: nil)
                let openVC = departmentStoryboard.instantiateViewController(withIdentifier: CONTROLLER.SALE) as! SaleTableViewController
                openVC.navigationItem.title = "Sale"
                self.navigationController?.pushViewController(openVC, animated: true)
            }
            
            
        case 2:
            print("Language")
        case 3:
            print("Logout")
    //            let loginViewController = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
        let login = storyboard?.instantiateViewController(withIdentifier: "LoginViewControllerID") as! LoginViewController
    //            login.setNavigationTitle(title: "Logout")
        self.navigationController?.pushViewController(login, animated: true)
        default:
            print("Default")
            
        }
    }
}
