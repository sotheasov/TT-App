//
//  OverallTableViewHeader.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/12/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class OverallTableViewHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var btnCalendarOverallOutlet: UIButton!
    @IBOutlet weak var btnLastOverallOutlet: UIButton!
    @IBOutlet weak var btnPreviousOverallOutlet: UIButton!
    @IBOutlet weak var lbAbsenceOverallOutlet: UILabel!
    @IBOutlet weak var lbLateOverallOutlet: UILabel!
    @IBOutlet weak var lbPresentOverallOutlet: UILabel!
    
    func setData(present : String, late : String, absence : String){
        lbPresentOverallOutlet.text = present
        lbLateOverallOutlet.text = late
        lbAbsenceOverallOutlet.text = absence
        
    }
}
