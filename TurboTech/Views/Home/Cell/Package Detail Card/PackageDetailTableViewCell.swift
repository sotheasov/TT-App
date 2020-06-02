//
//  PackageDetailTableViewCell.swift
//  TurboTech
//
//  Created by sq on 5/22/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class PackageDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var packageTypeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bodyView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setView(){
        headerView.clipsToBounds = true
        headerView.layer.cornerRadius = SIZE.RADIUS_CARD
        headerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bodyView.clipsToBounds = true
        bodyView.layer.cornerRadius = SIZE.RADIUS_CARD
        bodyView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        applyButton.layer.cornerRadius = SIZE.RADIUS_BUTTON
        
    }
    
    func setData(package : PackageDetail){
//        print("Detail setup data")
        let ln = "EN"
        self.tag = package.packageId
        packageTypeLabel.text = ln == "EN" ? package.nameEn : package.nameKh
        priceLabel.text = package.price
        monthLabel.text = (ln == "EN" ? "/ month":"/ ខែ")
        speedLabel.text = package.speed
//        print(package.detailEn)
        detailTextView?.text = ln == "EN" ? package.detailEn : package.detailKh
    }
    
}
