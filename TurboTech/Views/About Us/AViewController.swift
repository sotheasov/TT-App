//
//  ViewController.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/29/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class AViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let login = storyboard?.instantiateViewController(withIdentifier: "LoginViewControllerID") as! LoginViewController
        //            login.setNavigationTitle(title: "Logout")
            self.navigationController?.pushViewController(login, animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
