//
//  CreateTicketViewController.swift
//  TurboTech
//
//  Created by sq on 6/16/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class CreateTicketViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var serverityLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var organizationTextField: UITextField!
    @IBOutlet weak var serverityTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var tabGesture: UITapGestureRecognizer!
    // MARK: - Data
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    func setup(){
        setupNotification()
        localized()
        self.view.backgroundColor = UIColor(white: 0.6, alpha: 0.6)
    }
    
    func localized() {
        
    }
    
}

extension CreateTicketViewController {
    
    func setupNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        addDoneButtonOnKeyboard()
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
        self.subjectTextField.inputAccessoryView = toolBar
        self.subjectTextField.autocorrectionType = .no
        self.contactTextField.inputAccessoryView = toolBar
        self.contactTextField.autocorrectionType = .no
        self.organizationTextField.inputAccessoryView = toolBar
        self.organizationTextField.autocorrectionType = .no
        self.serverityTextField.inputAccessoryView = toolBar
        self.serverityTextField.autocorrectionType = .no
        self.categoryTextField.inputAccessoryView = toolBar
        self.categoryTextField.autocorrectionType = .no

    }
    
    @objc func doneButtonAction() {
        self.subjectTextField.resignFirstResponder()
        self.contactTextField.resignFirstResponder()
        self.organizationTextField.resignFirstResponder()
        self.serverityTextField.resignFirstResponder()
        self.categoryTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var contentInset : UIEdgeInsets = self.scrollView.contentInset
            contentInset.bottom = keyboardSize.size.height + 8
            scrollView.contentInset = contentInset
        }
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @IBAction func viewGesturePressed(_ sender: UITapGestureRecognizer) {
        let posX = sender.location(in: view.self).x;
        let posY = sender.location(in: view.self).y;
        let minX = containerView.frame.minX;
        let maxX = containerView.frame.maxX;
        let minY = containerView.frame.minY;
        let maxY = containerView.frame.maxY;
        if ( (posX >= minX && posX <= maxX) && (posY >= minY && posY <= maxY) ) == false{
            self.dismiss(animated: true) {}
        }
    }
}
