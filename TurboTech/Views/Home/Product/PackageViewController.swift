//
//  PackageViewController.swift
//  TurboTech
//
//  Created by sq on 5/21/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class PackageViewController: UIViewController {
    
    lazy var packageList : [Package] = []
    lazy var softwareList : [SoftwareSolution] = []
    lazy var productViewModel = ProductViewModel()
    
    let lang = LanguageManager.shared.language
    
    private var navItemTitle : String = "Unknown".localized
    private var packageId : Int = 0
    
    @IBOutlet weak var packageTableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

        productViewModel.productViewModelDelegate = self
        if packageId == 3 {
//            print("fetch software solution")
            productViewModel.fetchSoftwareSolution()
        }
        else{
            productViewModel.fetchAllPackage(type: packageId)
        }
    }
    
    func setUpView(){
        navigationItem.title = navItemTitle
        setTableView()
    }
    
    func setNavigationTitle(title : String){
        self.navItemTitle = title
    }
    
    func setPackageId(id : Int){
        self.packageId = id
    }
    

}

extension PackageViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        packageId == 3 ? softwareList.count : packageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = packageTableView.dequeueReusableCell(withIdentifier: "SubMenuCellID") as! SubMenuTableViewCell
//        print("MY ID IS : ", packageId)
        if packageId == 3 {
            cell.setData(software: softwareList[indexPath.row])
        } else {
            cell.setData(package: packageList[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.packageTableView.frame.size.height
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
    
    func setTableView(){
        packageTableView.dataSource = self
        packageTableView.delegate = self
        packageTableView.register(UINib(nibName: "SubMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SubMenuCellID")

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if (packageId == 2 && cell?.tag == 19){
            let packageVC = storyboard?.instantiateViewController(withIdentifier: "PackageViewControllerID") as! PackageViewController
            packageVC.modalPresentationStyle = .fullScreen
            packageVC.setNavigationTitle(title: lang == "en" ? packageList[indexPath.row].nameEn : packageList[indexPath.row].nameKh)
            packageVC.setPackageId(id: 5)
            self.navigationController?.pushViewController(packageVC, animated: true)
        }
        else if packageId == 3 {
            let webApp = storyboard?.instantiateViewController(withIdentifier: "WebApplicationViewControllerID") as! WebApplicationViewController
            webApp.modalPresentationStyle = .fullScreen
            webApp.setSoftware(software: softwareList[indexPath.row])
            self.navigationController?.pushViewController(webApp, animated: true)
            
//                packageVC.modalPresentationStyle = .fullScreen
//            packageVC.setNavigationTitle(title: packageList[indexPath.row].nameEn)
//                packageVC.setPackageId(id: cell!.tag)
//                self.navigationController?.pushViewController(packageVC, animated: true)
        }
        else {
            let packageVC = storyboard?.instantiateViewController(withIdentifier: "PackageDetailViewControllerID") as! PackageDetailViewController
            packageVC.modalPresentationStyle = .fullScreen
            packageVC.setNavigationTitle(title: lang == "en " ? packageList[indexPath.row].nameEn : packageList[indexPath.row].nameKh)
            packageVC.setPackageId(id: cell!.tag)
            self.navigationController?.pushViewController(packageVC, animated: true)
        }
    }
    
}
    
    
extension PackageViewController : ProductViewModelDelegate {
    func responseSoftwareSolution(solutions: [SoftwareSolution]) {
        self.softwareList = solutions
//        print("SS work")
        self.packageTableView.reloadData()
    }
    
    func responsePackageDetail(packageDetails: [PackageDetail]) {
        
    }
    
    func responsePackage(packages: [Package]) {
        self.packageList = packages
//        print("Package View : ", self.packageList.count)
//        print(packageId)
        self.packageTableView.reloadData()
    }
    
    func responseProduct(products: [Product]) {
    }
    
}
