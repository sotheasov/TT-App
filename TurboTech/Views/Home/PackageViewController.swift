//
//  PackageViewController.swift
//  TurboTech
//
//  Created by sq on 5/21/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class PackageViewController: UIViewController {
    
    var packageList : [Package] = []
    lazy var productViewModel = ProductViewModel()
    
    private var navItemTitle : String = "Unknown"
    private var packageId : Int = 0
    
    @IBOutlet weak var packageTableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        productViewModel.productViewModelDelegate = self
        productViewModel.fetchAllPackage(type: packageId)
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
        packageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = packageTableView.dequeueReusableCell(withIdentifier: "SubMenuCellID") as! SubMenuTableViewCell
        cell.setData(package: packageList[indexPath.row])
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
        
    }
    
}
    
    
extension PackageViewController : ProductViewModelDelegate {
    func responsePackage(packages: [Package]) {
        self.packageList = packages
        self.packageTableView.reloadData()
    }
    
    func responseProduct(products: [Product]) {
    }
    
}
