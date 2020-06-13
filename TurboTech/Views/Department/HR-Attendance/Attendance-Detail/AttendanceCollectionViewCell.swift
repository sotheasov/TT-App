//
//  AttendanceCollectionViewCell.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/27/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class AttendanceCollectionViewCell: UICollectionViewCell {
    
    // IBOutlet of AttendanceCollectionViewCell
    @IBOutlet weak var lbNameAttendanceBoxOutlet: UILabel!
    @IBOutlet weak var leadingCoverConstraintOutlet: NSLayoutConstraint!
    @IBOutlet weak var trailingCoverConstraintOutlet: NSLayoutConstraint!
    @IBOutlet weak var coverAttendanceViewCellOutlet: UIView!
    @IBOutlet weak var profileCellImageViewOutlet: UIImageView!
    @IBOutlet weak var numberAttendanceLabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Call Function
        customAttendanceCollectionViewCell()
    }
    
    
    func customAttendanceCollectionViewCell() {
        coverAttendanceViewCellOutlet.layer.cornerRadius = 10
        coverAttendanceViewCellOutlet.shadowStyle(radius: 4, color: .black, offset: CGSize(width: -0.5, height: 3), opacity: 0.8)
        
        profileCellImageViewOutlet.layer.cornerRadius = profileCellImageViewOutlet.frame.height/2
        profileCellImageViewOutlet.layer.borderWidth = 2
        profileCellImageViewOutlet.layer.borderColor = COLOR.COLOR_PRESENT.cgColor
        
        
    }
}


