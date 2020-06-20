//
//  ComingSoonViewController.swift
//  TurboTech
//
//  Created by sq on 6/20/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class ComingSoonViewController: UIViewController {

    @IBOutlet weak var comingSoonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comingSoonLabel.text = "coming soon".localized
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
