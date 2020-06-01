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
    @IBOutlet weak var leadingCoverConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingCoverConstraint: NSLayoutConstraint!
    @IBOutlet weak var coverAttendanceViewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Call Function
        customAttendanceCollectionViewCell()
    }
    
    func customAttendanceCollectionViewCell() {
//        coverAttendanceViewCell.layer.cornerRadius = 12
//        coverAttendanceViewCell.shadowStyle(radius: 6, color: .black, offset: CGSize(width: -0.5, height: 3), opacity: 1)
        //(red: 0.20, green: 0.67, blue: 0.88, alpha: 1.00)
//        let backgroundColor = COLOR.RED
//        coverAttendanceViewCell.backgroundColor = backgroundColor
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
