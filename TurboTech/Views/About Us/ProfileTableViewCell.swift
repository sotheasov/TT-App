//
//  ProfileTableViewCell.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/25/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var subContentView: UIView!
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var iconCell: UIImageView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        customProfileTableViewCell()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func customProfileTableViewCell() {
        
        subContentView.shadowStyle(radius: 10, color: .black, offset: CGSize(width: 0, height: 10), opacity: 0.6)
    }
    
    
}
