//
//  DeviceTableViewController.swift
//  TurboTech
//
//  Created by sq on 5/28/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class DeviceTableViewController: UITableViewController {

    let saleViewModel = SaleViewModel()
    var deviceList = [Device]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DeviceTableViewCell", bundle: nil), forCellReuseIdentifier: "DeviceTableViewCellID")
        tableView.register(UINib(nibName: "DeviceHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "DeviceHeaderViewID")
        tableView.backgroundView = UIImageView(image: UIImage(named: "3"))
        DispatchQueue.main.async {
            self.saleViewModel.fetchDevices { (devices) in
                self.deviceList = devices
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        deviceList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceTableViewCellID") as! DeviceTableViewCell
        cell.setData(device: deviceList[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DeviceHeaderViewID") as! DeviceHeaderView
        header.nameLabel.text = "Device"
        header.priceLabel.text = "Price"
//        header.dotView.createDottedLine(width: 2, color: COLOR.WHITE.cgColor)
        return header
    }
}
