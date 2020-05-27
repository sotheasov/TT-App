//
//  AppDelegate.swift
//  TurboTech
//
//  Created by sq on 5/19/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let MAP_API_KEY = "AIzaSyBmftqoMbNwOoSqoe0EW9xnuSEhjlizAHQ"
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UITabBar.appearance().barTintColor = TAB.COLOR
        UITabBar.appearance().tintColor = TAB.SELECTED_COLOR
//        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = TAB.UNSELECTED_COLOR.withAlphaComponent(TAB.UISELECTED_ALPHA)
        
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.barTintColor = COLOR.RED
        navBarAppearance.tintColor = COLOR.WHITE
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: COLOR.WHITE,
                NSAttributedString.Key.font: UIFont(descriptor: UIFontDescriptor(fontAttributes: [
                    UIFontDescriptor.AttributeName.textStyle: UIFont.TextStyle.headline,
                    UIFontDescriptor.AttributeName.name: UIFontDescriptor(name: "Quicksand-bold", size: 20)
                ]), size: 20)
        ]
        navBarAppearance.isTranslucent = true
        
        GMSServices.provideAPIKey(MAP_API_KEY)
        GMSPlacesClient.provideAPIKey(MAP_API_KEY)
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

