//
//  DepartmentTableViewCell.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/27/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class DepartmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverViewCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        customDepartmentTableViewCell()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func customDepartmentTableViewCell() {
        coverViewCell.shadowStyle(radius: 10, color: .black, offset: CGSize(width: 0, height: 10), opacity: 0.8)
    }
    
}
