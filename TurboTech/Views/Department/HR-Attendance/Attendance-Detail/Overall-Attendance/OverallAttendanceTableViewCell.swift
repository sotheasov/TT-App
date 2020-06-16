//
//  OverallAttendanceTableViewCell.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/11/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class OverallAttendanceTableViewCell: UITableViewCell {

    @IBOutlet weak var coverColorOverallAttendanceViewOutlet: UIView!
    @IBOutlet weak var coverOverallAttendanceViewCellOutlet: UIView!
    @IBOutlet weak var lbOverallAttendanceStatusOutlet: UILabel!
    @IBOutlet weak var lbOverallNameAttendanceOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Call Function
        customOverallAttendanceTableViewCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(_ overall : AttendanceProtocol){
        lbOverallNameAttendanceOutlet.text = overall.name
        lbOverallAttendanceStatusOutlet.text = overall.statusName
        if overall.statusName == "Late" {
            coverColorOverallAttendanceViewOutlet.backgroundColor = COLOR.COLOR_LATE
        } else if overall.statusName == "Present" {
            coverColorOverallAttendanceViewOutlet.backgroundColor = COLOR.COLOR_PRESENT
        } else if overall.statusName == "Absent" {
            coverColorOverallAttendanceViewOutlet.backgroundColor = COLOR.COLOR_ABSENCE
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coverColorOverallAttendanceViewOutlet.roundCorners(corners: [.topLeft, .bottomLeft], radius: SIZE.RADIUS)
    }
    
    func customOverallAttendanceTableViewCell() {
        coverOverallAttendanceViewCellOutlet.layer.cornerRadius = SIZE.RADIUS
        coverOverallAttendanceViewCellOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 0.5), opacity: 0.7)
        
        coverColorOverallAttendanceViewOutlet.backgroundColor = COLOR.COLOR_LATE
    }
    
}
