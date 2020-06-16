//
//  LoginViewController.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/20/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    // IBOutlet of LoginViewController
    @IBOutlet weak var loginProfileImageViewOutlet: UIImageView!
    @IBOutlet weak var txtLoginUsernameOutlet: UITextField!
    @IBOutlet weak var txtLoginPasswordOutlet: UITextField!
    @IBOutlet weak var btnLoginOutlet: UIButton!
    @IBOutlet weak var scrollView : UIScrollView!
    
    // Declare Variable
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call Function
        customLoginViewController()
    }
    
    func setup(){
        setupNotification()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localize()
        setup()
    }
    
    private func localize(){
        self.navigationItem.title = "login".localized
        self.tabBarController?.tabBar.items![0].title = "home".localized
        self.tabBarController?.tabBar.items![1].title = "location".localized
        self.tabBarController?.tabBar.items![2].title = "message".localized
        self.tabBarController?.tabBar.items![3].title = "profile".localized
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
        
//        loginProfileImageViewOutlet.layer.cornerRadius = loginProfileImageViewOutlet.frame.height/2
//        loginProfileImageViewOutlet.layer.borderWidth = 2
//        loginProfileImageViewOutlet.layer.borderColor = COLOR.RED.cgColor
        
        btnLoginOutlet.layer.cornerRadius = SIZE.RADIUS
        btnLoginOutlet.layer.borderWidth = 2
        btnLoginOutlet.layer.borderColor = COLOR.WHITE.cgColor
        btnLoginOutlet.tintColor = COLOR.RED
        btnLoginOutlet.shadowStyle(radius: 6, color: .black, offset: CGSize(width: -0.5, height: 4), opacity: 1)
    }
    
    // Action Button
    @IBAction func btnLogin(_ sender: UIButton) {
        txtLoginUsernameOutlet.layer.borderColor = UIColor.gray.cgColor
        txtLoginPasswordOutlet.layer.borderColor = UIColor.gray.cgColor
        
        guard let username = txtLoginUsernameOutlet.text, let password = txtLoginPasswordOutlet.text else {return}
        
        if username == "" || password == "" {
            if username == "" {
                txtLoginUsernameOutlet.layer.borderColor = UIColor.red.cgColor
            }
            if password == "" {
                txtLoginPasswordOutlet.layer.borderColor = UIColor.red.cgColor
            }
            print(username, password)
            return
        }
        
        print(username, password)
        
        DispatchQueue.main.async {
            sender.pulsate()
            self.loginViewModel.userLogin(username: username, password: password) { (isSucceed, user)  in
                
                print(isSucceed)
                
                if !isSucceed {
                    self.showAndDismissAlert(title: "please try again".localized, message: "", style: .alert, second: 1.5)
                    return
                } else {
                    if let u = user {
                        if u.phone == "" {
                            return
                        } else {
                            User.resetUser()
                            UserDefaults.standard.set(nil, forKey: "authVerificationID")
                            self.requestCode(phone: u.phone)
                            let verifyVC = self.storyboard?.instantiateViewController(withIdentifier: "VerifyLoginViewControllerID") as! VerifyLoginViewController
                            verifyVC.setUser(username, password, u)
                            self.navigationController?.pushViewController(verifyVC, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    private func requestCode(phone : String){
//        let p = phone.phoneNumber
        let p = "+85593775782"
        print("Phone is : ", p)
        PhoneAuthProvider.provider().verifyPhoneNumber(p, uiDelegate: nil) { (verificationID, error) in
          if let error = error {
            User.resetUser()
            UserDefaults.standard.set(nil, forKey: "authVerificationID")
            self.showAndDismissAlert(title: error.localizedDescription, message: nil, style: .alert, second: 3.0)
            return
          }
            Auth.auth().languageCode = LanguageManager.shared.language;
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        }
    }
}

extension LoginViewController : UITextFieldDelegate {
    
    func setDelegate(){
        txtLoginUsernameOutlet.delegate = self
        txtLoginPasswordOutlet.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 10
        if let nextResponder = textField.superview?.viewWithTag(nextTag){
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
}


extension LoginViewController {
    
    func setupNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func addDoneButtonOnKeyboard() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = COLOR.BLUE
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
//        self.onTimeTextField.inputAccessoryView = toolBar
//        self.onTimeTextField.autocorrectionType = .no

    }
    
    @objc func doneButtonAction() {
//        self.onTimeTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                var contentInset : UIEdgeInsets = self.scrollView.contentInset
                contentInset.bottom = keyboardSize.size.height + 20
                scrollView.contentInset = contentInset
            }
        }

        @objc func keyboardWillHide(_ notification: NSNotification) {
            let contentInset:UIEdgeInsets = UIEdgeInsets.zero
            scrollView.contentInset = contentInset
        }
}


