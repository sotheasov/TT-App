//
//  AppDelegate.swift
//  TurboTech
//
//  Created by sq on 5/19/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UITabBar.appearance().barTintColor = UIColor.red
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor.white.withAlphaComponent(0.5)
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.barTintColor = COLOR.BLUE
        navBarAppearance.tintColor = COLOR.WHITE
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: COLOR.WHITE,
                NSAttributedString.Key.font: UIFont(descriptor: UIFontDescriptor(fontAttributes: [
                    UIFontDescriptor.AttributeName.textStyle: UIFont.TextStyle.headline,
                    UIFontDescriptor.AttributeName.name: UIFontDescriptor(name: "Quicksand-bold", size: 20)
                ]), size: 20)
        ]
        navBarAppearance.isTranslucent = true
        
//        if let tabBarController = self.window!.rootViewController as? UITabBarController {
//            tabBarController.selectedIndex = 1
//        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being crreated.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

