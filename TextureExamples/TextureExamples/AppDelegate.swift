//
//  AppDelegate.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/6/8.
//

import UIKit
import AsyncDisplayKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()

        return true
    }
}

