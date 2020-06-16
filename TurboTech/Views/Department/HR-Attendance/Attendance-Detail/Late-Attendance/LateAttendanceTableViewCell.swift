//
//  LateAttendanceTableViewCell.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/10/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class LateAttendanceTableViewCell: UITableViewCell {
    
    // IBOutlet of LateAttendanceTableViewCell
    @IBOutlet weak var lbTimeLateOutlet: UILabel!
    @IBOutlet weak var coverLateAttendanceViewCellOutlet: UIView!
    @IBOutlet weak var coverColorLateAttendanceViewCellOutlet: UIView!
    @IBOutlet weak var lbNameLateOutlet: UILabel!
    @IBOutlet weak var lbNameStatusOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Call Function
       customPresentAttendanceTableViewCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coverColorLateAttendanceViewCellOutlet.roundCorners(corners: [.topLeft, .bottomLeft], radius: SIZE.RADIUS)
    }
    
    func setData(_ late : PresentAttendance){
        lbNameLateOutlet.text = late.name
        lbTimeLateOutlet.text = late.time
        lbNameStatusOutlet.text = late.statusName
    }
    
    func customPresentAttendanceTableViewCell() {
        coverLateAttendanceViewCellOutlet.layer.cornerRadius = SIZE.RADIUS
        coverLateAttendanceViewCellOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 0.5), opacity: 0.7)
        
        coverColorLateAttendanceViewCellOutlet.backgroundColor = COLOR.COLOR_LATE
    }
}
