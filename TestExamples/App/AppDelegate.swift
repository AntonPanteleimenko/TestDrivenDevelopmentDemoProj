//
//  AppDelegate.swift
//  TestExamples
//
//  Created by Anton Panteleimenko on 07.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = SignUpViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

