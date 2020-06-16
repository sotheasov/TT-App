//
//  PackageCRMCellTableViewCell.swift
//  TurboTech
//
//  Created by sq on 6/10/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class PackageCRMCellTableViewCell: UITableViewCell {

    @IBOutlet weak var packageLabel: UILabel!
    @IBOutlet weak var radioButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func isSelected(_ selected : Bool){
        selected ? clearSelected() : setSelected()
    }
    
    func setSelected(){
        radioButton.setImage(UIImage(named: "circle"), for: .normal)
//        radioButton.tintColor = .white
    }
    
    func clearSelected(){
        radioButton.setImage(UIImage(named: "check-circle"), for: .normal)
//        radioButton.tintColor = .blue
    }
    
    func setPackage(package : CRMPackage) {
        packageLabel.text = package.name
        self.tag = package.id
    }
    
}
