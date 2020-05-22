//
//  ProductViewController.swift
//  TurboTech
//
//  Created by sq on 5/21/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    var productList : [Product] = []
    var productViewModel = ProductViewModel()
    
    @IBOutlet weak var productTableView: UITableView!
    
    private var navItemTitle : String = "Unknown"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        productViewModel.productViewModelDelegate = self
        productViewModel.fetchAllProducts()
    }
    
    func setUpView(){
        navigationItem.title = navItemTitle
        setTableView()
    }
    
    func setNavigationTitle(title : String){
        self.navItemTitle = title
    }
}

extension ProductViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTableView.dequeueReusableCell(withIdentifier: "SubMenuCellID") as! SubMenuTableViewCell
        cell.setData(product: productList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.productTableView.frame.size.height
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
        productTableView.dataSource = self
        productTableView.delegate = self
        productTableView.register(UINib(nibName: "SubMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SubMenuCellID")

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.tag == 1 || cell?.tag == 2 {
            let packageVC = storyboard?.instantiateViewController(withIdentifier: "PackageViewControllerID") as! PackageViewController
            packageVC.modalPresentationStyle = .fullScreen
            packageVC.setNavigationTitle(title: "Package")
            packageVC.setPackageId(id: cell!.tag)
            self.navigationController?.pushViewController(packageVC, animated: true)
        }
    }
    
    
    
    
}

extension ProductViewController : ProductViewModelDelegate {
    func responsePackage(packages: [Package]) {
        
    }
    
    func responseProduct(products: [Product]) {
        self.productList = products
        self.productList.append(Product(id: 3, nameEn: "Software Solution", nameKh: "ដំណោះស្រាយកម្មវិធី", imageUrl: " https://www.at-languagesolutions.com/en/wp-content/uploads/2016/06/http-1.jpg"))
        self.productTableView.reloadData()
    }
    
    
}
