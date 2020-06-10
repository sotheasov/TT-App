//
//  InternetConnection.swift
//  TurboTech
//
//  Created by sq on 6/4/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import Network

class InternetConnection {
    
    static let shared = InternetConnection()
    
    func checkConnection(_ target : UIViewController){
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
            }
            else {
                print("There's no internet connection.")
                DispatchQueue.main.async {
                    target.showAndDismissAlert(target, title: "No Internet Connection".localized, message: "Check Your Connection please!".localized, style: .alert, second: 5)
                }
//                monitor.cancel()
            }
        }
        
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.start(queue: queue)
    }
    
}
