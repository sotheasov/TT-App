//
//  LoginViewController.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/20/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // IBOutlet of LoginViewController
    @IBOutlet weak var loginProfileImageViewOutlet: UIImageView!
    @IBOutlet weak var txtLoginUsernameOutlet: UITextField!
    @IBOutlet weak var txtLoginPasswordOutlet: UITextField!
    @IBOutlet weak var btnLoginOutlet: UIButton!
    
    // Declare Variable
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call Function
        customLoginViewController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let isLogin = false
        if !isLogin {
            self.dismiss(animated: true) {
            }
        }
    }
    
    func customLoginViewController(){
        txtLoginUsernameOutlet.layer.cornerRadius = SIZE.RADIUS
        txtLoginUsernameOutlet.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: txtLoginUsernameOutlet.frame.height))
        txtLoginUsernameOutlet.leftViewMode = .always
        txtLoginUsernameOutlet.shadowStyle(radius: 6, color: .black, offset: CGSize(width: -0.5, height: 4), opacity: 1)
        
        txtLoginPasswordOutlet.layer.cornerRadius = SIZE.RADIUS
        txtLoginPasswordOutlet.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: txtLoginPasswordOutlet.frame.height))
        txtLoginPasswordOutlet.leftViewMode = .always
        txtLoginPasswordOutlet.shadowStyle(radius: 6, color: .black, offset: CGSize(width: -0.5, height: 4), opacity: 1)
        
        loginProfileImageViewOutlet.layer.cornerRadius = loginProfileImageViewOutlet.frame.height/2
        loginProfileImageViewOutlet.layer.borderWidth = 2
        loginProfileImageViewOutlet.layer.borderColor = COLOR.RED.cgColor
        
        btnLoginOutlet.layer.cornerRadius = SIZE.RADIUS
        btnLoginOutlet.layer.borderWidth = 2
        btnLoginOutlet.layer.borderColor = COLOR.WHITE.cgColor
        btnLoginOutlet.tintColor = COLOR.RED
        btnLoginOutlet.shadowStyle(radius: 6, color: .black, offset: CGSize(width: -0.5, height: 4), opacity: 1)
    }
    
    // Action Button
    @IBAction func btnLogin(_ sender: UIButton) {
        DispatchQueue.main.async {
            sender.pulsate()
            self.loginViewModel.userLogin(username: "get user from textfield", password: "get password for textfield") { (user) in
                if user.id == "0" {
                    print("Wrong Login")
                }
                else {
                    print("Login Success")
                    self.dismiss(animated: false) {
                        
                    }
                }
            }
        }
    }
}




