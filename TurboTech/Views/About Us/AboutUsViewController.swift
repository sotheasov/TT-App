//
//  AboutUsViewController.swift
//  TurboTech
//
//  Created by sq on 5/19/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    
    @IBOutlet weak var subViewContainer: UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customProfile()
        
    }
    
    func customProfile() {
        containerView.layer.cornerRadius = 20
        subViewContainer.layer.cornerRadius = 20
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.height/2
        userProfileImageView.layer.borderWidth = 5
        userProfileImageView.layer.borderColor = UIColor.white.cgColor
        
    }

}
