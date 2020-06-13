//
//  FeedBackViewController.swift
//  TurboTech
//
//  Created by sq on 5/25/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import iOSDropDown

class FeedBackViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var problemTypeLabel: UILabel!
    @IBOutlet weak var problemDetailLabel: UILabel!
    
    @IBOutlet weak var complainTypeDropDown: DropDown!
    @IBOutlet weak var complainTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!

    let lang = LanguageManager.shared.language
    var ids = [Int]()
    var titlesKh = [String]()
    var titlesEn = [String]()
    
//    let selectOption = ["Internet", "Payment", "Human Resources", "Service"]
    var problemTypeList = [ProblemType]()
    override func viewDidLoad() {
        super.viewDidLoad()
        localized()
        fetchData()
//        complainTypeTextField.delegate = self
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
//
//        view.addGestureRecognizer(tap)
    }

    func localized(){
        titleLabel.text = "problem complain".localized
        problemTypeLabel.text = "problem type".localized
        problemDetailLabel.text = "problem detail".localized
        submitButton.setTitle("submit".localized, for: .normal)
    }
    
    func fetchData(){
        let helpDeskViewModel = HelpDeskViewModel()
        DispatchQueue.main.async {
            helpDeskViewModel.fetchProblemType { (problemTypes) in
                self.problemTypeList = problemTypes
                self.setupDropDown()
                print(problemTypes.count)
            }
        }
    }
    
    func setupDropDown(){
        complainTextView.delegate = self
//        complainTypeDropDown.optionArray = selectOption
        for type in self.problemTypeList {
            ids.append(type.id)
            titlesEn.append(type.nameEn)
            titlesKh.append(type.nameKh)
        }
//        complainTypeDropDown.optionIds = ids
        complainTypeDropDown.text = lang == "en" ? titlesEn[0] : titlesKh[0]
        complainTypeDropDown.optionArray = lang == "en" ? titlesEn : titlesKh
        complainTypeDropDown.selectedRowColor = .red
        complainTypeDropDown.selectedIndex = 0
        submitButton.setTitle("Submit", for: .highlighted)
        submitButton.layer.cornerRadius = SIZE.RADIUS_BUTTON
        complainTextView.layer.cornerRadius = SIZE.RADIUS_CARD
        complainTypeDropDown.layer.cornerRadius = SIZE.RADIUS

        complainTypeDropDown.didSelect{(selectedText , index ,id) in
            self.complainTypeDropDown.text = ""//.localized
            self.complainTypeDropDown.tag = index
        }
    }
    
    @IBAction func submitComplainPress(_ sender: Any) {
        let helpDeskViewModel = HelpDeskViewModel()
        let complain = UserComplain(type: "", question: "")
        complain.setType(type: self.titlesEn[self.complainTypeDropDown.tag])
        complain.setQuestion(question: complainTextView.text ?? "")
        print("user text : ", complain.question)
        
        DispatchQueue.main.async {
            helpDeskViewModel.postComplainMessage(complain: complain) { (message) in
                let shMsg = self.lang == "en" ? "\(self.titlesEn[self.complainTypeDropDown.tag]) " + "problem".localized : "problem".localized + " \(self.titlesKh[self.complainTypeDropDown.tag])"
                self.showAndDismissAlert(title: shMsg, message: message.localized, style: .alert, second: 2)
                print(message)
            }
        }
    }
    
    
    
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//           // if keyboard size is not available for some reason, dont do anything
//           return
//        }
//      // move the root view up by the distance of keyboard height
//      self.view.frame.origin.y = 0 - keyboardSize.height
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//      // move back the root view origin to zero
//        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//
//          // if keyboard size is not available for some reason, dont do anything
//          return
//        }
//      self.view.frame.origin.y = 0
//        var shouldMoveViewUp = false
//
//        // if active text field is not nil
//        if let complainTypeTextField = complainTypeTextField {
//
//          let bottomOfTextField = complainTypeTextField.convert(complainTypeTextField.bounds, to: self.view).maxY;
//
//          let topOfKeyboard = self.view.frame.height - keyboardSize.height
//
//          // if the bottom of Textfield is below the top of keyboard, move up
//          if bottomOfTextField > topOfKeyboard {
//            shouldMoveViewUp = true
//          }
//        }
//
//        if(shouldMoveViewUp) {
//          self.view.frame.origin.y = 0 - keyboardSize.height
//        }
//
//        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
//        scrollView.contentInset = contentInsets
//        scrollView.scrollIndicatorInsets = contentInsets
//    }
//
//    @objc func dismissKeyboard() {
//        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        view.endEditing(true)
//        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
//
//
//        // reset back the content inset to zero after keyboard is gone
//        scrollView.contentInset = contentInsets
//        scrollView.scrollIndicatorInsets = contentInsets
//    }
}


extension FeedBackViewController : UITextFieldDelegate {
  // when user select a textfield, this method will be called
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // set the activeTextField to the selected textfield
//    self.complainTypeTextField = textField
  }
    
  // when user click 'done' or dismiss the keyboard
  func textFieldDidEndEditing(_ textField: UITextField) {
//    self.complainTypeTextField = nil
  }
}

extension FeedBackViewController : UITextViewDelegate {
    
}


extension UIViewController {
    func showAndDismissAlert(title : String?, message : String?, style : UIAlertController.Style, second : Double){
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        present(ac, animated: true)
        let time = DispatchTime.now() + second//second
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.dismiss(animated: true) { }
        }
    }
    
    func showAndDismissAlert(_ target : UIViewController, title : String?, message : String?, style : UIAlertController.Style, second : Double){
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        present(ac, animated: true)
        let time = DispatchTime.now() + second//second
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.dismiss(animated: true) { }
        }
    }
}
