//
//  DeviceTableViewCell.swift
//  TurboTech
//
//  Created by sq on 5/28/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var devicePriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setView(){
        containerView.layer.cornerRadius = SIZE.RADIUS_CARD
    }
    
    func setData(device : Device) {
        self.deviceNameLabel.text = device.name
        self.devicePriceLabel.text = "\(device.price)"
    }
    
}
