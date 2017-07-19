//
//  AppDelegate.swift
//  E-commerce
//
//  Created by YE on 2017/7/18.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if UserDefaults.standard.bool(forKey: UserDefaultsKey.isFirstLoad) == false {
            
            if let guideViewController = storyboard.instantiateViewController(withIdentifier: "GuideViewController") as? GuideViewController {
                window?.rootViewController = guideViewController
            }
            UserDefaults.standard.set(true, forKey: UserDefaultsKey.isFirstLoad)

        }
        else {
            
            if let mainTabbarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarViewController") as? MainTabBarViewController {
                window?.rootViewController = mainTabbarController
            }
            
        }
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {  }
    
    func applicationDidEnterBackground(_ application: UIApplication) { }
    
    func applicationWillEnterForeground(_ application: UIApplication) { }
    
    func applicationDidBecomeActive(_ application: UIApplication) { }
    
    func applicationWillTerminate(_ application: UIApplication) { }
    
    
}

