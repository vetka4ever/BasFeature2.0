//
//  AppDelegate.swift
//  BasketApp2.0
//
//  Created by Daniil on 01.12.2021.
//

import UIKit
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        
        let view = SignView()
        let root = UINavigationController(rootViewController: view)
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        return true
    }

   


}

