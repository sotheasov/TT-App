//
//  AppDelegate.swift
//  TurboTech
//
//  Created by sq on 5/19/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//
// S5AZC8X8J7
// APP ID : S5AZC8X8J7.com.turbotech.turbotech-ios
/*
 Name:TurboTech
 Key ID:TWSAK32XLQ
 Services:Apple Push Notifications service (APNs)
 */
import UIKit
import GooglePlaces
import GoogleMaps
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
//    static let position : Position = .Admin
    static var user : User?
    
    let MAP_API_KEY = "AIzaSyBmftqoMbNwOoSqoe0EW9xnuSEhjlizAHQ"
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if UserDefaults.standard.string(forKey: "LanguageCode") == nil {
            LanguageManager.shared.language = "km"
        }
        
        if UserDefaults.standard.bool(forKey: "isLogin") {
            let loginViewModel = LoginViewModel()
            loginViewModel.fetchCurrentUser()
        }
        
        UITabBar.appearance().barTintColor = TAB.COLOR
        UITabBar.appearance().tintColor = TAB.SELECTED_COLOR
//        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = TAB.UNSELECTED_COLOR.withAlphaComponent(TAB.UISELECTED_ALPHA)
        UITabBarItem.appearance().setTitleTextAttributes([
//            NSAttributedString.Key.foregroundColor: COLOR.WHITE,
                NSAttributedString.Key.font: UIFont(descriptor: UIFontDescriptor(fontAttributes: [
                    UIFontDescriptor.AttributeName.textStyle: UIFont.TextStyle.headline,
                    UIFontDescriptor.AttributeName.name: UIFontDescriptor(name: "Quicksand-Bold", size: 12)
                ]), size: 12)
        ], for: .normal)
        
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
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
              options: authOptions,
              completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being crreated.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
