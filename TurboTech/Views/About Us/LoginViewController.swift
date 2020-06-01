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
    @IBOutlet weak var loginProfileImageView: UIImageView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
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
        txtUsername.layer.cornerRadius = SIZE.RADIUS
        txtUsername.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: txtUsername.frame.height))
        txtUsername.leftViewMode = .always
        txtUsername.shadowStyle(radius: 10, color: .black, offset: CGSize(width: 10, height: 20), opacity: 0.6)
        
        txtPassword.layer.cornerRadius = SIZE.RADIUS
        txtPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: txtPassword.frame.height))
        txtPassword.leftViewMode = .always
        txtPassword.shadowStyle(radius: 10, color: .black, offset: CGSize(width: 10, height: 20), opacity: 0.6)
        
        loginProfileImageView.layer.cornerRadius = loginProfileImageView.frame.height/2
        loginProfileImageView.layer.borderWidth = 5
        loginProfileImageView.layer.borderColor = UIColor.white.cgColor
        
        btnLogin.layer.cornerRadius = SIZE.RADIUS
        btnLogin.layer.borderWidth = 2
        btnLogin.layer.borderColor = COLOR.WHITE.cgColor
        btnLogin.tintColor = COLOR.RED
        btnLogin.shadowStyle(radius: 10, color: .black, offset: CGSize(width: 10, height: 20), opacity: 0.6)
    }
    
    // Button Action
    @IBAction func loginPress(_ sender: Any) {
        DispatchQueue.main.async {
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

// Custom Style
extension UIView {
    @discardableResult
    func shadowStyle (radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float) -> UIView {
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
//        self.layer.shadowPath = UIBezierPath(roundedRect: <#T##CGRect#>, cornerRadius: <#T##CGFloat#>)
        return self
    }
    
    func setColorGradient(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
//        print(self.frame)
//        gradientLayer.bounds = self.bounds
        gradientLayer.frame = self.layer.bounds
//        gradientLayer.bounds = self.bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 2.0)
        gradientLayer.endPoint = CGPoint(x: 2.0, y: 1.0)
//        gradientLayer.position = self.center //CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
//        layer.insertSublayer(gradientLayer, at: 0)
        
    }
}



