//
//  AbsenceAttendanceTableViewCell.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/10/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class AbsenceAttendanceTableViewCell: UITableViewCell {
    
    // IBOutlet of AbsenceAttendanceTableViewCell
    @IBOutlet weak var coverColorAbsenceAttendanceViewOutlet: UIView!
    @IBOutlet weak var lbNameAbsenceOutlet: UILabel!
    @IBOutlet weak var coverAbsenceAttendanceViewCellOutlet: UIView!
    
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
        coverColorAbsenceAttendanceViewOutlet.roundCorners(corners: [.topLeft, .bottomLeft], radius: SIZE.RADIUS)
    }
    
    func setData(_ absence : AbsenceAttendance){
        lbNameAbsenceOutlet.text = absence.name
    }
    
    func customPresentAttendanceTableViewCell() {
        coverAbsenceAttendanceViewCellOutlet.layer.cornerRadius = SIZE.RADIUS
        coverAbsenceAttendanceViewCellOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 0.5), opacity: 0.7)
        
        coverColorAbsenceAttendanceViewOutlet.backgroundColor = COLOR.COLOR_ABSENCE
    }
    
}
