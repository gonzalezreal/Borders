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
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        installRootViewController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func installRootViewController() {
        let bordersViewController = BordersViewController(countryName: "China")
        let navigationController = UINavigationController(rootViewController: bordersViewController)
        window?.rootViewController = navigationController
    }
}

