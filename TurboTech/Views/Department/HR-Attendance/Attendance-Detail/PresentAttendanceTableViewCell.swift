//
//  PresentAttendanceTableViewCell.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/10/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class PresentAttendanceTableViewCell: UITableViewCell {
    
    // IBOutlet of PresentAttendanceTableViewCell
    @IBOutlet weak var lbTimePresentOutlet: UILabel!
    @IBOutlet weak var lbNamePresentOutlet: UILabel!
    @IBOutlet weak var lbNameStatusPresentOutlet: UILabel!
    @IBOutlet weak var coverPresentAttendanceViewCellOutlet: UIView!
    @IBOutlet weak var coverColorPresentAttendanceViewCellOutlet: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Call Function
        customPresentAttendanceTableViewCell()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setData(_ present : PresentAttendance){
        lbNamePresentOutlet.text = present.name
        lbTimePresentOutlet.text = present.time
        lbNameStatusPresentOutlet.text = present.statusName
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coverColorPresentAttendanceViewCellOutlet.roundCorners(corners: [.topLeft, .bottomLeft], radius: SIZE.RADIUS)
    }
    
    func customPresentAttendanceTableViewCell() {
        coverPresentAttendanceViewCellOutlet.layer.cornerRadius = SIZE.RADIUS
        coverPresentAttendanceViewCellOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 0.5), opacity: 0.7)
        
        coverColorPresentAttendanceViewCellOutlet.backgroundColor = COLOR.COLOR_PRESENT
    }
    
}
