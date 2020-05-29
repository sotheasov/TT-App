//
//  AttendanceCollectionViewCell.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/27/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class AttendanceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var leadingCoverConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingCoverConstraint: NSLayoutConstraint!
    // IBOutlet of AttendanceCollectionViewCell
    @IBOutlet weak var coverAttendanceViewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Call Function
        customAttendanceCollectionViewCell()
    }
    
    func customAttendanceCollectionViewCell() {
        coverAttendanceViewCell.layer.cornerRadius = 12
        coverAttendanceViewCell.shadowStyle(radius: 6, color: .black, offset: CGSize(width: -0.5, height: 4), opacity: 1)
    }
    
    func setConstraint(right : Bool){
        if right {
            self.trailingCoverConstraint.constant = 12.5
            self.leadingCoverConstraint.constant = 20
        }
        else {
            self.trailingCoverConstraint.constant = 20
            self.leadingCoverConstraint.constant = 12.5
        }
    }
}
