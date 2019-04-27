//
//  AppDelegate.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        installRootViewController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func installRootViewController() {
        let bordersViewController = BordersViewController(countryName: "Germany")
        let navigationController = UINavigationController(rootViewController: bordersViewController)
        window?.rootViewController = navigationController
    }
}

