//
//  LateReportAttendanceTableViewCell.swift
//  TurboTech
//
//  Created by Unknown on 6/19/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class LateReportAttendanceTableViewCell: UITableViewCell {

    @IBOutlet weak var coverColorTotalReportAttendanceViewCellOutlet: UIView!
    @IBOutlet weak var coverTotalReportAttendanceViewCellOutlet: UIView!
    @IBOutlet weak var lbNameTotalReportAttendanceOutlet: UILabel!
    @IBOutlet weak var lbDateTotalReportAttendanceOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        customLateReportAttendanceTableViewCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        coverColorTotalReportAttendanceViewCellOutlet.roundCorners(corners: [.topLeft, .bottomLeft], radius: SIZE.RADIUS)

    }
    
    func customLateReportAttendanceTableViewCell() {
        coverTotalReportAttendanceViewCellOutlet.layer.cornerRadius = SIZE.RADIUS
        coverTotalReportAttendanceViewCellOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 0.5), opacity: 0.7)
        
        coverColorTotalReportAttendanceViewCellOutlet.backgroundColor = COLOR.COLOR_LATE
    }
}
