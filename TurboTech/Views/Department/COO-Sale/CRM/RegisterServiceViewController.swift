//
//  RegisterServiceViewController.swift
//  TurboTech
//
//  Created by sq on 6/8/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import iOSDropDown

class RegisterServiceViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
//    @IBOutlet weak var genderTextField: DropDown!
    @IBOutlet weak var genderButton: UIButton!
    
    
    @IBOutlet weak var provinceTextField: UITextField!
    @IBOutlet weak var districtTextField: UITextField!
    @IBOutlet weak var communeTextField: UITextField!
    @IBOutlet weak var villageTextField: UITextField!
    @IBOutlet weak var homeStreetTextField: UITextField!
    
    
    @IBOutlet weak var chooseProductButton: UIButton!
    @IBOutlet weak var shareLocationButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    let lang = LanguageManager.shared.language
    var isShared = false
    var isMale = true
    
//    var pickerData = ["PS", "PP", "SR", "BTB"]
    var addressList = [Address]()
    var provinceList = [Address]()
    var districtList = [Address]()
    var communeList = [Address]()
    var villageList = [Address]()
//    var id : String = ""
    var proId : Int?
    var disId : Int?
    var comId : Int?
    var vilId : Int?
    let picker = UIPickerView()
    let saleViewModel = SaleViewModel()
    var activeTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView(){
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
        
        self.addDoneButtonOnKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        firstNameTextField.customizeRegister()
        lastNameTextField.customizeRegister()
        emailTextField.customizeRegister()
        phoneNumberTextField.customizeRegister()
        genderButton.setTitle("male".localized, for: .normal)
        provinceTextField.customizeRegister()
        provinceTextField.setDropDownImage()
        communeTextField.customizeRegister()
        communeTextField.setDropDownImage()
        districtTextField.customizeRegister()
        districtTextField.setDropDownImage()
        villageTextField.customizeRegister()
        villageTextField.setDropDownImage()
        homeStreetTextField.customizeRegister()
        
        chooseProductButton.layer.cornerRadius = chooseProductButton.frame.height / 2
        registerButton.layer.cornerRadius = registerButton.frame.height / 2
        chooseProductButton.setTitle("choose our internet package".localized, for: .normal)
        shareLocationButton.setTitle("share location".localized, for: .normal)
        registerButton.setTitle("register".localized, for: .normal)
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        phoneNumberTextField.delegate = self
        homeStreetTextField.delegate = self
        
        
        activeTextField.delegate = self
        
        provinceTextField.delegate = self
        districtTextField.delegate = self
        communeTextField.delegate = self
        villageTextField.delegate = self
        
        picker.dataSource = self
        picker.delegate = self
    }
    
    @objc func donePicker(_ sender : UIBarButtonItem){
        activeTextField.resignFirstResponder()
    }
    
    
    @IBAction func shareLocationPress(_ sender: Any) {
//        shareLocationButton
        isShared = !isShared
        if isShared {
            shareLocationButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            shareLocationButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func genderSwitchPress(_ sender: Any) {
        isMale = !isMale
        if isMale {
            genderButton.setImage(UIImage(named: "male"), for: .normal)
            genderButton.setTitle("male".localized, for: .normal)
            genderButton.setTitleColor(.systemBlue, for: .normal)
        } else {
            genderButton.setImage(UIImage(named: "female"), for: .normal)
            genderButton.setTitle("female".localized, for: .normal)
            genderButton.setTitleColor(.systemPink, for: .normal)
        }
    }
    
    @IBAction func choosePackagePress(_ sender: Any) {
        let choosePackageVC = storyboard?.instantiateViewController(identifier: "PackageCRMViewControllerID") as! PackageCRMViewController
        choosePackageVC.modalPresentationStyle = .overCurrentContext
        self.present(choosePackageVC, animated: true, completion: nil)
    }
    
    @IBAction func registerPress(_ sender: Any) {
        guard let fname = firstNameTextField.text, let lname = lastNameTextField.text /*, let email = emailTextField.text*/, let phone = phoneNumberTextField.text else { return }
        let gray = UIColor.gray.cgColor
        let red = UIColor.red.cgColor
        firstNameTextField.layer.borderColor = gray
        lastNameTextField.layer.borderColor = gray
        phoneNumberTextField.layer.borderColor = gray
        let isValidateFirstName = Validaton.shared.validationName(name: fname)
        if !isValidateFirstName {
            firstNameTextField.layer.borderColor = red
        }
        let isValidateLastName = Validaton.shared.validationName(name: lname)
        if !isValidateLastName {
            lastNameTextField.layer.borderColor = red
        }
        let isValidationPhone = Validaton.shared.validaPhoneNumber(phoneNumber: phone)
        if !isValidationPhone {
            phoneNumberTextField.layer.borderColor = red
        }
        
        if isValidateFirstName && isValidateLastName && isValidationPhone {
            print("CAN POST REGISTER, BUT NEED SELLER NAME")
        }
    }
}

extension UITextField {
    func customizeRegister(color : CGColor, radius : CGFloat){
        self.layer.masksToBounds = true
        self.layer.borderColor = color
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = radius
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        self.leftViewMode = .always
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [.font : UIFont.boldSystemFont(ofSize: 14.0)])
    }
    
    func customizeRegister(){
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = self.frame.height / 2
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        self.leftViewMode = .always
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder?.localized ?? "", attributes: [.font : UIFont.boldSystemFont(ofSize: 14.0)])
    }
    
    func setDropDownImage(){
        let b : CGFloat = 44.0
        let bounds = CGRect(x: 0, y: 0, width: b, height: b)
        let s : CGFloat = 12.0
        let h : CGFloat = b - 2.75 * s
        let y = (b - h)/2
        let imageBounds = CGRect(x: s, y: y, width: b - 2*s , height: h)
        let image = UIImage(systemName: "arrowtriangle.down.fill")
        let imageView = UIImageView(frame: imageBounds)
        imageView.image = image
//        imageView.contentMode = .scaleAspectFit
        self.rightView = UIView(frame: bounds)
//        self.rightView?.backgroundColor = .red
        self.rightView?.addSubview(imageView)
        self.rightViewMode = .always
    }
}

extension RegisterServiceViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        addressList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return lang == "en" ? addressList[row].nameEn : addressList[row].nameKh
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        id = addressList[row].gazcode
        activeTextField.text = lang == "en" ? addressList[row].nameEn : addressList[row].nameKh
        print("SELECTED ROW : ", row)
        if activeTextField == provinceTextField && row != proId {
            districtTextField.isEnabled = true
            communeTextField.isEnabled = false
            villageTextField.isEnabled = false
            proId = row //addressList[row].gazcode
            
            self.districtTextField.text = nil
            self.disId = nil
            self.communeTextField.text = nil
            self.comId = nil
            self.villageTextField.text = nil
            self.vilId = nil
        } else if activeTextField == districtTextField && row != disId{
            communeTextField.isEnabled = true
            villageTextField.isEnabled = false
            disId = row //addressList[row].gazcode
            self.communeTextField.text = nil
            self.comId = nil
            self.villageTextField.text = nil
            self.vilId = nil
        } else if activeTextField == communeTextField && row != comId{
            villageTextField.isEnabled = true
            comId = row //addressList[row].gazcode
            self.villageTextField.text = nil
            self.vilId = nil
        } else if activeTextField == villageTextField && row != vilId{
            vilId = row //addressList[row].gazcode
        }
    }
    
}

extension RegisterServiceViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        
        if self.provinceTextField.isEditing == true {
                setData(type: .province, id: "")
        } else if self.districtTextField.isEditing == true {
            guard let id = proId else {
                return
            }
            setData(type: .district, id: provinceList[id].gazcode)
        } else if self.communeTextField.isEditing == true {
            guard let id = disId else {
                return
            }
            setData(type: .commune, id: districtList[id].gazcode)
        } else if self.villageTextField.isEditing == true {
            guard let id = comId else {
                return
            }
            setData(type: .village, id: communeList[id].gazcode)
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case provinceTextField, districtTextField, communeTextField, villageTextField:
            return false
        default:
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func setData(type : ADDRESS, id : String){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = COLOR.RED
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        activeTextField.inputView = picker
        activeTextField.inputAccessoryView = toolBar
        
        DispatchQueue.main.async {
            print("WORK")
            self.saleViewModel.fetchAddress(addressType: type, id: id) { (list) in
                print("cur id : ", id, type)
                self.addressList = list
                var pickID : Int = 0
                switch type {
                    case .province :
                        self.provinceList = list
                        if let id = self.proId {
                            pickID = id
                        }
                    case .district :
                        self.districtList = list
                        if let id = self.disId {
                            pickID = id
                        }
                    case .commune :
                        self.communeList = list
                        if let id = self.comId {
                            pickID = id
                        }
                    case .village :
                        self.villageList = list
                        if let id = self.vilId {
                            pickID = id
                        }
                }
                self.picker.reloadAllComponents()
                self.picker.selectRow(pickID, inComponent: 0, animated: true)
                self.pickerView(self.picker, didSelectRow: pickID, inComponent: 0)
            }
        }
    }
    

    func addDoneButtonOnKeyboard() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = COLOR.BLUE
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        self.firstNameTextField.inputAccessoryView = toolBar
        self.firstNameTextField.autocorrectionType = .no
        self.lastNameTextField.inputAccessoryView = toolBar
        self.lastNameTextField.autocorrectionType = .no
        self.emailTextField.inputAccessoryView = toolBar
        self.emailTextField.autocorrectionType = .no
        self.phoneNumberTextField.inputAccessoryView = toolBar
        self.phoneNumberTextField.autocorrectionType = .no
        self.homeStreetTextField.inputAccessoryView = toolBar
        self.homeStreetTextField.autocorrectionType = .no

    }

    func doneButtonAction() {
        self.firstNameTextField.resignFirstResponder()
        self.lastNameTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.phoneNumberTextField.resignFirstResponder()
        self.homeStreetTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var contentInset : UIEdgeInsets = self.scrollView.contentInset
            contentInset.bottom = keyboardSize.size.height + 20
            scrollView.contentInset = contentInset
//            if view.frame.origin.y == 0 {
//                self.view.frame.origin.y -= keyboardSize.height
//            }
        }
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
//        if view.frame.origin.y != 0 {
//            self.view.frame.origin.y = 0
//        }
    }
}
