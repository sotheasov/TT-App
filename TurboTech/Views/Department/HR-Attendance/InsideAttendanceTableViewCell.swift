//
//  InsideAttendanceTableViewCell.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/4/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class InsideAttendanceTableViewCell: UITableViewCell {
    
    // IBOutlet of InsideAttendanceTableViewCell
    @IBOutlet weak var coverColorInsideAttendanceViewOutlet: UIView!
    @IBOutlet weak var coverInsideAttendanceViewCellOutlet: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Call Function
        customInsideAttendanceTableViewCell()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coverColorInsideAttendanceViewOutlet.roundCorners(corners: [.topLeft, .bottomLeft], radius: SIZE.RADIUS)
    }
    
    func setData( attandnce : AttendanceProtocol){
        if PresentAttendance.self as? AttendanceProtocol.Type != nil {
            let present : PresentAttendance = attandnce as! PresentAttendance
            timeLabel.text = present.time
        }
//        timeLabel.text = attandnce.time
        nameLabel.text = attandnce.name
        statusNameLabel.text = attandnce.statusName
    }
    
    func isLateView(){
        coverColorInsideAttendanceViewOutlet.backgroundColor = COLOR.COLOR_LATE
    }
    
    func isPresentView(){
        coverColorInsideAttendanceViewOutlet.backgroundColor = COLOR.COLOR_PRESENT
    }
    
    func isAbsenceView(){
        coverColorInsideAttendanceViewOutlet.backgroundColor = COLOR.COLOR_ABSENCE
    }
    
    
    func customInsideAttendanceTableViewCell() {
        coverInsideAttendanceViewCellOutlet.layer.cornerRadius = SIZE.RADIUS
        coverInsideAttendanceViewCellOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 1), opacity: 0.5)
        
        coverColorInsideAttendanceViewOutlet.backgroundColor = COLOR.COLOR_PRESENT
    }
    
}


