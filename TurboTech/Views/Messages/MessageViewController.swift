//
//  MessageViewController.swift
//  TurboTech
//
//  Created by sq on 5/19/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeLanguage), name: NSNotification.Name(rawValue: "changed"), object: nil)
        
//        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        myView.backgroundColor = .blue
//        self.view.addSubview(myView)
//        
//        let myView2 = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
//        myView2.backgroundColor = .green
//        self.view.addSubview(myView2)
//        
//        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        btn.tintColor = .black
//        btn.setTitle("Hello", for: .normal)
//        btn.addTarget(self, action: #selector(hello), for: .touchUpInside)
//        self.view.addSubview(btn)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            btn.widthAnchor.constraint(equalToConstant: 100),
//            btn.heightAnchor.constraint(equalToConstant: 100),
//            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            btn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
//            ])
//        localized()
        
    }
    
    @IBAction func btn(_ sender: Any) {
        
        let department = UIStoryboard(name: BOARD.DEPARTMENT, bundle: nil)
        let crmVC = department.instantiateViewController(withIdentifier: "TicketTableViewControllerID") as! TicketTableViewController
        crmVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(crmVC, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localized()
    }
    
    func localized(){
        label.text = "Coming Soon".localized
    }
    
    @objc
    func hello(_ : UIButton){
        print("Hello")
        
    }
    
    @objc
    func changeLanguage(){
    }
}
