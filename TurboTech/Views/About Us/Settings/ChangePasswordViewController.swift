//
//  ChangePasswordViewController.swift
//  TurboTech
//
//  Created by sq on 6/15/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet var tabGesture: UITapGestureRecognizer!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var changeLanguageLabel: UILabel!
    @IBOutlet weak var oldPassTextField: UITextField!
    @IBOutlet weak var newPassTextField: UITextField!
    @IBOutlet weak var newConfirmPassTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localized()
        setup()
    }
    
    private func localized(){
        changeLanguageLabel.text = "change password".localized
        oldPassTextField.placeholder = "old password".localized
        newPassTextField.placeholder = "new password".localized
        newConfirmPassTextField.placeholder = "confirm new password".localized
        confirmButton.setTitle("confirm".localized, for: .normal)
    }
    
    private func setup(){
        self.view.backgroundColor = .clear
        self.view.backgroundColor = UIColor(white: 0.5, alpha: 0.4)
        self.view.addGestureRecognizer(tabGesture)
        oldPassTextField.layer.borderWidth = 1.0
        newPassTextField.layer.borderWidth = 1.0
        newConfirmPassTextField.layer.borderWidth = 1.0
    }

    @IBAction func confirmPressed(_ sender: Any) {
        print("WORK NO")
        guard let old = oldPassTextField.text, let newP1 = newPassTextField.text, let u = AppDelegate.user else {
            return
        }
        print("WORK GUARD")
        if isAcceptablePassword() {
            DispatchQueue.main.async {
                let loginViewModel = LoginViewModel()
                loginViewModel.userChangePassword(username: u.userName, oldPass: old, newPass: newP1) { (status) in
                    self.showAndDismissAlert(title: status ? "successfully".localized : "try again".localized, message: nil, style: .alert, second: 2.0)
                }
            }
        }
    }
    
    private func isAcceptablePassword() -> Bool {
        print("WORK is")
        var condition = false
        let red = UIColor.red.cgColor
        let gray = UIColor.gray.cgColor
        oldPassTextField.layer.borderColor = gray
        newPassTextField.layer.borderColor = gray
        newConfirmPassTextField.layer.borderColor = gray
        guard let old = oldPassTextField.text, let newP1 = newPassTextField.text, let newP2 = newConfirmPassTextField.text else {
            return false
        }
        
        if old == "" {
            oldPassTextField.layer.borderColor = red
            condition = true
        }
        
        
        if newP1 == "" {
            newPassTextField.layer.borderColor = red
            condition = true
        }
        
        
        if newP2 == "" {
            newConfirmPassTextField.layer.borderColor = red
            condition = true
        }
        
        
        if newP1 == newP2 && !condition {
            return true
        } else {
            newPassTextField.layer.borderColor = red
            newConfirmPassTextField.layer.borderColor = red
            self.showAndDismissAlert(title: "wrong confirm password".localized, message: nil, style: .alert, second: 1.0)
        }
        
        return false
    }
    
    @IBAction func viewGesturePressed(_ sender: UITapGestureRecognizer) {
        let posX = sender.location(in: view.self).x;
        let posY = sender.location(in: view.self).y;
        let minX = alertView.frame.minX;
        let maxX = alertView.frame.maxX;
        let minY = alertView.frame.minY;
        let maxY = alertView.frame.maxY;
        if ( (posX >= minX && posX <= maxX) && (posY >= minY && posY <= maxY) ) == false{
            self.dismiss(animated: true, completion: nil);
        }
    }
    
    
}
