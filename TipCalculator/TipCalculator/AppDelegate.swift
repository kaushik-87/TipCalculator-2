//
//  AppDelegate.swift
//  TipCalculator
//
//  Created by Dev on 7/23/17.
//  Copyright © 2017 Kaushik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let userDefaults = UserDefaults.standard
        let minVal = (userDefaults.float(forKey: "minVal") == 0.0) ? 0.00 : userDefaults.float(forKey: "minVal")
        userDefaults.set(minVal, forKey: "minVal")

        let maxVal = (userDefaults.float(forKey: "maxVal") == 0.0) ? 30.00 : userDefaults.float(forKey: "maxVal")
        userDefaults.set(maxVal, forKey: "maxVal")

        let defaultVal = (userDefaults.float(forKey: "defaultVal") == 0.0) ? 10.00 : userDefaults.float(forKey: "defaultVal")
        userDefaults.set(defaultVal, forKey: "defaultVal")
        
        let maxShare = (userDefaults.float(forKey: "maxShare") == 0) ? 10 : userDefaults.float(forKey: "maxShare")
        userDefaults.set(maxShare, forKey: "maxShare")
        
        var billAmount = "0"
        if((userDefaults.string(forKey: "billAmount")) != nil)
        {
            billAmount = userDefaults.string(forKey: "billAmount")!
        }
        userDefaults.set(billAmount, forKey:"billAmount")
        
        let splitBy = (userDefaults.integer(forKey: "splitBy") == 0) ? 1 : userDefaults.integer(forKey: "splitBy")
        userDefaults.set(splitBy, forKey:"splitBy")

        userDefaults.synchronize()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//        let userDefaults = UserDefaults.standard
//        let currentDateInSec = NSDate.timeIntervalSinceReferenceDate
//        userDefaults.set(currentDateInSec, forKey: "latestSavedDateAndTime")
//        userDefaults.synchronize()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let userDefaults = UserDefaults.standard
        let currentDateInSec = NSDate.timeIntervalSinceReferenceDate
        userDefaults.set(currentDateInSec, forKey: "latestSavedDateAndTime")
        userDefaults.synchronize()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

        let userDefaults = UserDefaults.standard
        let currentDateInSec = NSDate.timeIntervalSinceReferenceDate
        let lastSavedTime = userDefaults.double(forKey: "latestSavedDateAndTime")
        if((currentDateInSec - lastSavedTime) > (10*60))
        {
            resetUserPreference()
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        let userDefaults = UserDefaults.standard
//        let currentDateInSec = NSDate.timeIntervalSinceReferenceDate
//        let lastSavedTime = userDefaults.double(forKey: "latestSavedDateAndTime")
//        if((currentDateInSec - lastSavedTime) > 30)
//        {
//            resetUserPreference()
//        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func resetUserPreference() -> Void {
        let userDefaults = UserDefaults.standard
        userDefaults.set(0.00, forKey: "minVal")
        userDefaults.set(30.00, forKey: "maxVal")
        userDefaults.set(10.00, forKey: "defaultVal")
        userDefaults.set(10, forKey: "maxShare")
        userDefaults.set(1, forKey:"splitBy")
        userDefaults.set("0", forKey:"billAmount")
        userDefaults.synchronize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ResetUI"), object: nil)
        
    }


}

