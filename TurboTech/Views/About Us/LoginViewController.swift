//
//  LoginViewController.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/20/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //IBOutlet of LoginViewController
    @IBOutlet weak var loginProfileImageView: UIImageView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customLoginViewController()
        btnLogin.shadowStyle(radius: 10, color: .black, offset: CGSize(width: 10, height: 20), opacity: 0.6)
        txtUsername.shadowStyle(radius: 10, color: .black, offset: CGSize(width: 10, height: 20), opacity: 0.6)
        txtPassword.shadowStyle(radius: 10, color: .black, offset: CGSize(width: 10, height: 20), opacity: 0.6)
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
        
        txtPassword.layer.cornerRadius = SIZE.RADIUS
        txtPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: txtPassword.frame.height))
        txtPassword.leftViewMode = .always
        
        loginProfileImageView.layer.cornerRadius = loginProfileImageView.frame.height/2
        loginProfileImageView.layer.borderWidth = 5
        loginProfileImageView.layer.borderColor = UIColor.white.cgColor
        
        btnLogin.layer.cornerRadius = SIZE.RADIUS
        btnLogin.layer.borderWidth = 2
        btnLogin.layer.borderColor = COLOR.WHITE.cgColor
        btnLogin.tintColor = COLOR.RED
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
}


