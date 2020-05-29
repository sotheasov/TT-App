//
//  ProductViewController.swift
//  TurboTech
//
//  Created by sq on 5/21/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    lazy var productList : [Product] = []
    lazy var productViewModel = ProductViewModel()
    
    @IBOutlet weak var productTableView: UITableView!
    var position : Position?
    private var navItemTitle : String = "Unknown"
    private var typeId : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        switch typeId {
        case 0:
            productViewModel.productViewModelDelegate = self
            productViewModel.fetchAllProducts()
        case 2 :
            dataForHelpDesk()
        default:
            print("WRONG HZ PRO IT DEFULT")
        }
    }
    
    func setUpView(){
        navigationController?.delegate = self
        navigationItem.title = navItemTitle
        setTableView()
    }
    
    func setNavigationTitle(title : String){
        self.navItemTitle = title
    }
    
    func setTypeId(id : Int){
        self.typeId = id
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
        switch typeId {
        case 0 :
            let cell = tableView.cellForRow(at: indexPath)
            let packageVC = storyboard?.instantiateViewController(withIdentifier: "PackageViewControllerID") as! PackageViewController
            packageVC.modalPresentationStyle = .fullScreen
            packageVC.setNavigationTitle(title: productList[indexPath.row].nameEn)
            packageVC.setPackageId(id: cell!.tag)
            self.navigationController?.pushViewController(packageVC, animated: true)
        case 2:
            print("Complain")
            if indexPath.row == 0 {
                let packageVC = storyboard?.instantiateViewController(withIdentifier: "FeedBackViewControllerID") as! FeedBackViewController
                packageVC.modalPresentationStyle = .fullScreen
//                packageVC.setNavigationTitle(title: productList[indexPath.row].nameEn)
//                packageVC.setPackageId(id: cell!.tag)
                self.navigationController?.pushViewController(packageVC, animated: true)
            }
            else if indexPath.row == 1 {
                print("FAQs")
                let FAQsVC = storyboard?.instantiateViewController(identifier: "FAQsTableViewControllerID") as! FAQsTableViewController
                FAQsVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(FAQsVC, animated: true)
                
            }
        default:
            print("Hey You Eng Love Me man? SI")
        }
        
    }
    
    
    
    
}

extension ProductViewController : ProductViewModelDelegate {
    func responseSoftwareSolution(solutions: [SoftwareSolution]) {
        
    }
    
    func responsePackageDetail(packageDetails: [PackageDetail]) {
        
    }
    
    func responsePackage(packages: [Package]) {
        
    }
    
    func responseProduct(products: [Product]) {
        self.productList = products
        self.productList.append(Product(id: 3, nameEn: "Software Solution", nameKh: "ដំណោះស្រាយកម្មវិធី", imageUrl: " https://www.at-languagesolutions.com/en/wp-content/uploads/2016/06/http-1.jpg"))
        self.productTableView.reloadData()
    }
    
    func dataForHelpDesk(){
        self.productList.append(Product(id: 0, nameEn: "Complain", nameKh: "បញ្ចេញមតិ", imageUrl: "icons8-task_completed_filled"))
        self.productList.append(Product(id: 1, nameEn: "FAQs", nameKh: "សំណួរ​ចម្លើយ", imageUrl: "icons8-faq_filled"))
        self.productTableView.reloadData()
    }
    
}


extension ProductViewController : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print("WORK On Product Delegate")
        (viewController as? DepartmentTableViewController)?.setOpenType(position: position!)// Here you pass the to your original view controller
    }
}
