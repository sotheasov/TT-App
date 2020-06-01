//
//  ViewController.swift
//  TurboTech
//
//  Created by sq on 5/19/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.green
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewControllerID")
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC, animated: false) {
            print("Show")
        }
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) -> Bool {

        print("WORK hz")
        let selectIndex : NSInteger = (tabBarController.viewControllers?.index(of: viewController))!

        if (selectIndex == 3) {
                let vc = LoginViewController()  // your new Controller

                var allviews = tabBarController.viewControllers
                 allviews?.remove(at: selectIndex)
                 allviews?.insert(vc, at: selectIndex)
            tabBarController.setViewControllers(allviews, animated: true)


                return false;

        }

        return true;

    }

//    @IBSegueAction func aboutus(_ coder: NSCoder, sender: Any?) -> UIViewController? {
//        return <#UIViewController(coder: coder)#>
//    }
//    
    
}

extension ViewController : UITabBarDelegate {
    
}

