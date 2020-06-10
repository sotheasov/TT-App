//
//  TotalAttendanceViewController.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/3/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class TotalAttendanceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func btnBackTotalAttendance(_ sender: UIButton) {
        sender.pulsate()
        self.dismiss(animated: true, completion: nil)
    }
}
