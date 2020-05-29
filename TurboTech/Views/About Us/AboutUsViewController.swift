//
//  AboutUsViewController.swift
//  TurboTech
//
//  Created by sq on 5/19/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    // IBOutlet of AboutUsViewController
    @IBOutlet weak var subContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    // Declare Variable
    var loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        subContainerView.shadowStyle(radius: 10, color: .gray, offset: CGSize(width: 10, height: 20), opacity: 0.8)
        let isLogin = false
        if !isLogin {
            let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewControllerID") as! LoginViewController
            loginVC.modalPresentationStyle = .fullScreen
//            loginVC.setNavigationTitle(title: "Product")
            self.navigationController?.pushViewController(loginVC, animated: false)
        }
        
        // Call Function
        customAboutUsViewController()
    }

    func customAboutUsViewController() {
        containerView.layer.cornerRadius = 20
        subContainerView.layer.cornerRadius = 20
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.height/2
        userProfileImageView.layer.borderWidth = 5
        userProfileImageView.layer.borderColor = UIColor.white.cgColor
    }
    
}


