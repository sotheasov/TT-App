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
    
    override func viewDidAppear(_ animated: Bool) {
        if let u = user {
            print(u.phone)
            sendVerifyCode(phone: u.phone)
        }
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
//            confirmPressed(confirmButton!)
        } else {
            confirmButton.isEnabled = false
            confirmButton.isHidden = true
        }
    }
    
    
    @IBAction func confirmPressed(_ sender: Any) {
        print("Nothing confirm")
        guard let code = onTimeTextField.text else {
            print("NIL CODE")
            return
        }
        if code != "" {
            verification(verificationCode: code)
        }
    }
    
    private func sendVerifyCode(phone : String){
        let p = phone.phoneNumber
        print(p)
        UserDefaults.standard.set(nil, forKey: "authVerificationID")
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        PhoneAuthProvider.provider().verifyPhoneNumber(p, uiDelegate: nil) { (verificationID, error) in
            
            if let error = error {
                self.showMessagePrompt(error.localizedDescription)
                UserDefaults.standard.set(nil, forKey: "authVerificationID")
                return
            }
            print("VerificationID : ", verificationID ?? "WRONG ID")
            Auth.auth().languageCode = LanguageManager.shared.language
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            
        }
    }
    
    private func verification(verificationCode : String){
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        if let verId = verificationID {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verId, verificationCode: verificationCode)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                    print("Error in verification")
                    UserDefaults.standard.set(nil, forKey: "authVerificationID")
                    return
                } else {
                    print("User can login with code")
                    User.setupUser(username: self.username, password: self.password, user: self.user)
                    let newVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileMainTableViewControllerID") as! ProfileMainTableViewController
                    self.navigationController?.viewControllers = [newVC]
                }
            }
        } else {
            UserDefaults.standard.set(nil, forKey: "authVerificationID")
            print("VerId is nil")
            let newVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewControllerID") as! LoginViewController
            self.navigationController?.viewControllers = [newVC]
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

private class SaveAlertHandle {
  static var alertHandle: UIAlertController?

  class func set(_ handle: UIAlertController) {
    alertHandle = handle
  }

  class func clear() {
    alertHandle = nil
  }

  class func get() -> UIAlertController? {
    return alertHandle
  }
}

extension UIViewController {
  /*! @fn showMessagePrompt
   @brief Displays an alert with an 'OK' button and a message.
   @param message The message to display.
   */
  func showMessagePrompt(_ message: String) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(okAction)
    present(alert, animated: false, completion: nil)
  }

  /*! @fn showTextInputPromptWithMessage
   @brief Shows a prompt with a text field and 'OK'/'Cancel' buttons.
   @param message The message to display.
   @param completion A block to call when the user taps 'OK' or 'Cancel'.
   */
  func showTextInputPrompt(withMessage message: String,
                           completionBlock: @escaping ((Bool, String?) -> Void)) {
    let prompt = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
      completionBlock(false, nil)
    }
    weak var weakPrompt = prompt
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
      guard let text = weakPrompt?.textFields?.first?.text else { return }
      completionBlock(true, text)
    }
    prompt.addTextField(configurationHandler: nil)
    prompt.addAction(cancelAction)
    prompt.addAction(okAction)
    present(prompt, animated: true, completion: nil)
  }

  /*! @fn showSpinner
   @brief Shows the please wait spinner.
   @param completion Called after the spinner has been hidden.
   */
  func showSpinner(_ completion: (() -> Void)?) {
    let alertController = UIAlertController(title: nil, message: "Please Wait...\n\n\n\n",
                                            preferredStyle: .alert)
    SaveAlertHandle.set(alertController)
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    spinner.color = UIColor(ciColor: .black)
    spinner.center = CGPoint(x: alertController.view.frame.midX,
                             y: alertController.view.frame.midY)
    spinner.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin,
                                .flexibleLeftMargin, .flexibleRightMargin]
    spinner.startAnimating()
    alertController.view.addSubview(spinner)
    present(alertController, animated: true, completion: completion)
  }

  /*! @fn hideSpinner
   @brief Hides the please wait spinner.
   @param completion Called after the spinner has been hidden.
   */
  func hideSpinner(_ completion: (() -> Void)?) {
    if let controller = SaveAlertHandle.get() {
      SaveAlertHandle.clear()
      controller.dismiss(animated: true, completion: completion)
    }
  }
}
