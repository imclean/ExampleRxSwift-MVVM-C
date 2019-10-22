//
//  AppDelegate.swift
//  BumpTestApp
//
//  Created by Iain McLean on 21/10/2019.
//  Copyright © 2019 Iain McLean. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator:MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        URLCache.shared = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: nil)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController()
        coordinator = MainCoordinator(navigationController: nav)
        coordinator?.start()
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }

}

