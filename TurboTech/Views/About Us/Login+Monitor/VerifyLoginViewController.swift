//
//  VerifyLoginViewController.swift
//  TurboTech
//
//  Created by sq on 6/13/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import Firebase

class VerifyLoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var onTimeTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var scrollView : UIScrollView!
    
    private var password : String!
    private var username : String!
    private var user : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        localize()
    }
    
    public func setUser(_ un : String, _ pa : String, _ us : User){
        password = pa
        username = un
        user = us
    }
    
    private func localize(){
        informationLabel.text = "please verify you code".localized
        confirmButton.setTitle("confirm".localized, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.onTimeTextField.becomeFirstResponder()
    }
    
    private func setup(){
        confirmButton.isEnabled = false
        confirmButton.isHidden = true
        self.addDoneButtonOnKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UITextField.textDidChangeNotification, object: onTimeTextField)
        onTimeTextField.delegate = self
        onTimeTextField.becomeFirstResponder()
        
        setupNotification()
    }
    
    @objc func keyboardDidShow(notification : NSNotification){
        if onTimeTextField.text?.count == 6 {
            confirmButton.isEnabled = true
            confirmButton.isHidden = false
            confirmPressed(confirmButton!)
        } else {
            confirmButton.isEnabled = false
            confirmButton.isHidden = true
        }
    }
    
    
    @IBAction func confirmPressed(_ sender: Any) {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        guard let verId = verificationID, let code = onTimeTextField.text else { return }
        let credential = PhoneAuthProvider.provider().credential(
        withVerificationID: verId,
        verificationCode: code)
        
        
        Auth.auth().signIn(with: credential)
        { (authResult, error) in
          if let error = error
          {
            User.resetUser()
            UserDefaults.standard.set(nil, forKey: "authVerificationID")
//            let authError = error as NSError
            // if (isMFAEnabled && authError.code == AuthErrorCode.secondFactorRequired.rawValue)
            // {
            //   // The user is a multi-factor user. Second factor challenge is required.
            //   // let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
            //   // var displayNameString = ""
            //   // for tmpFactorInfo in (resolver.hints)
            //   // {
            //   //   displayNameString += tmpFactorInfo.displayName ?? ""
            //   //   displayNameString += " "
            //   // }
            //   // self.showTextInputPrompt
            //   // (withMessage: "Select factor to sign in\n\(displayNameString)", completionBlock:
            //   // { userPressedOK, displayName in
            //   //   var selectedHint: PhoneMultiFactorInfo?
            //   //   // for tmpFactorInfo in resolver.hints
            //   //   // {
            //   //   //   // if (displayName == tmpFactorInfo.displayName)
            //   //   //   // {
            //   //   //   //   selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
            //   //   //   // }
            //   //   // }
            //   //   // PhoneAuthProvider.provider().verifyPhoneNumber(with: selectedHint!, uiDelegate: nil, multiFactorSession: resolver.session)
            //   //   // { verificationID, error in
            //   //   //   // if error != nil
            //   //   //   // {
            //   //   //   //   print("Multi factor start sign in failed. Error: \(error.debugDescription)")
            //   //   //   // }
            //   //   //   // else {
            //   //   //   //   // self.showTextInputPrompt
            //   //   //   //   // (withMessage: "Verification code for \(selectedHint?.displayName ?? "")", completionBlock:
            //   //   //   //   // { userPressedOK, verificationCode in
            //   //   //   //   //   let credential: PhoneAuthCredential? = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode!)
            //   //   //   //   //   let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator.assertion(with: credential!)
            //   //   //   //   //   // resolver.resolveSignIn(with: assertion!)
            //   //   //   //   //   // { authResult, error in
            //   //   //   //   //   //   // if error != nil
            //   //   //   //   //   //   // {
            //   //   //   //   //   //   //   print("Multi factor finanlize sign in failed. Error: \(error.debugDescription)")
            //   //   //   //   //   //   // }
            //   //   //   //   //   //   // else {
            //   //   //   //   //   //   //   self.navigationController?.popViewController(animated: true)
            //   //   //   //   //   //   // }
            //   //   //   //   //   // }
            //   //   //   //   // }
            //   //   //   //   // )
            //   //   //   // }
            //   //   // }
            //   // }
            //   // )
            // } else
//            {
//              self.showMessagePrompt(error.localizedDescription)
            self.showAndDismissAlert(title: error.localizedDescription, message: nil, style: .alert, second: 5.0)
            UserDefaults.standard.set(nil, forKey: "authVerificationID")
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewControllerID") as! LoginViewController
            self.navigationController?.viewControllers = [newViewController]
              return
//            }
            // ...
//            return
          }
          // User is signed in
          // ...
            User.setupUser(username: self.username, password: self.password, user: self.user)
            UserDefaults.standard.set(nil, forKey: "authVerificationID")
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileMainTableViewControllerID") as! ProfileMainTableViewController
            self.navigationController?.viewControllers = [newViewController]
        }
        
    }
    
}

extension VerifyLoginViewController {
    
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
        self.onTimeTextField.inputAccessoryView = toolBar
        self.onTimeTextField.autocorrectionType = .no

    }
    
    @objc func doneButtonAction() {
        self.onTimeTextField.resignFirstResponder()
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
