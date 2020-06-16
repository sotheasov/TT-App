//
//  TicketTableViewCell.swift
//  TurboTech
//
//  Created by sq on 6/16/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import SwipeCellKit

class TicketTableViewCell: SwipeTableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
    func setup(){
    }
    
    func setData(){
        
    }
    
}
