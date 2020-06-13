//
//  PackageCRMTableViewController.swift
//  TurboTech
//
//  Created by sq on 6/10/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class PackageCRMViewController: UIViewController {
    
//    @IBOutlet var pressedGesture: UITapGestureRecognizer!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var doneView: UIView!
    lazy var crmViewModel = CRMViewModel()
    var packageList = [CRMPackage]()
    var filterPackageList = [CRMPackage]()
    var onDoneBlock : ((_ id : Int, _ name : String) -> Void)?
    var selectedID : Int?
    var oldSelected : Int? 
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        self.view.backgroundColor = UIColor(white: 0.6, alpha: 0.6)
        
        tableView.register(UINib(nibName: "PackageCRMCellTableViewCell", bundle: nil), forCellReuseIdentifier: "PackageCRMCellTableViewCellID")
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.main.async {
            self.crmViewModel.fetchRegisterPackage { (packageList) in
                self.packageList = packageList
                if let oldId = self.oldSelected {
                    self.setSelected(id: oldId)
                }
                
                self.tableView.reloadData()
                print("PACKAGE WORK")
            }
        }
        setupSearchBar()
        doneButton.setTitle("done".localized, for: .normal)
        containerView.layer.cornerRadius = SIZE.RADIUS_CARD
        doneView.layer.cornerRadius = SIZE.RADIUS_CARD
    }
    
    func setupSearchBar(){
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "search package ...".localized
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        tableView.tableHeaderView = (searchBar)
    }
    
    @IBAction func donePressed(_ sender : UIButton){
        self.dismiss(animated: true) {
            if let id = self.selectedID {
                self.onDoneBlock!(id, self.getPackageName(id: id))
            }
        }
    }
    
//    @IBAction func viewGesturePressed(_ sender: UITapGestureRecognizer) {
//        let posX = sender.location(in: view.self).x;
//        let posY = sender.location(in: view.self).y;
//        let minX = containerView.frame.minX;
//        let maxX = containerView.frame.maxX;
//        let minY = containerView.frame.minY;
//        let maxY = containerView.frame.maxY;
//        if ( (posX >= minX && posX <= maxX) && (posY >= minY && posY <= maxY) ) == false{
//            self.dismiss(animated: true) {
//                if self.selectedID != nil {
//                    self.onDoneBlock!(10)
//                }
//            }
//        }
//    }
}

extension PackageCRMViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filterPackageList.isEmpty {
            return filterPackageList.count
        } else {
            return packageList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PackageCRMCellTableViewCellID", for: indexPath) as! PackageCRMCellTableViewCell
        if !filterPackageList.isEmpty {
            cell.setPackage(package: filterPackageList[indexPath.row])
            cell.isSelected(filterPackageList[indexPath.row].isSelected)
        } else {
            cell.setPackage(package: packageList[indexPath.row])
            cell.isSelected(packageList[indexPath.row].isSelected)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if let oldId = oldSelected {
            removeSelected(id: oldId)
            oldSelected = nil
        }
        if let id = selectedID {
            removeSelected(id: id)
        }
        self.tableView.reloadData()
        if !filterPackageList.isEmpty {
            filterPackageList[indexPath.row].isSelected = true
            selectedID = filterPackageList[indexPath.row].id
        }
        else {
            packageList[indexPath.row].isSelected = true
            selectedID = packageList[indexPath.row].id
        }
    }
    
    func removeSelected(id : Int) {
        var c = 0
        for package in packageList {
            if package.id == id {
                packageList[c].isSelected = false
                return
            }
            c += 1
        }
    }
    
    func setSelected(id : Int){
        var c = 0
        for package in packageList {
            if package.id == id {
                packageList[c].isSelected = true
                return
            }
            c += 1
        }
    }
    
    func getPackageName(id : Int) -> String{
        var c = 0
        for package in packageList {
            if package.id == id {
                return packageList[c].name
            }
            c += 1
        }
        return "NOT FOUND"
    }
     
    
}

extension PackageCRMViewController : UISearchBarDelegate, UISearchControllerDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            filterPackageList = packageList.filter({$0.name.lowercased().contains(searchText.lowercased())})
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        filterPackageList.removeAll()
    }
}
