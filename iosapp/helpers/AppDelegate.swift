//
//  AppDelegate.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManager
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var reach: Reach = Reach()
    var currentLanguage = "ru"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        currentLanguage = UserDefaults.standard.string(forKey: "language") ?? "ru"
        UserDefaults.standard.set(currentLanguage, forKey: "AppleLanguage")
        UserDefaults.standard.synchronize()
        Bundle.swizzleLocalization()
        
        let serviceFactory = ServiceFactory()
        let assemblyFactory = AssemblyFactory(serviceFactory: serviceFactory)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = UINavigationController(rootViewController: assemblyFactory.rootModule.assembleViewController()!)
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        IQKeyboardManager.shared().isEnabled = true
        
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
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
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}


extension AppDelegate {
    
    func restartApp() {
        let serviceFactory = ServiceFactory()
        let assemblyFactory = AssemblyFactory(serviceFactory: serviceFactory)
        let rootVC = UINavigationController(rootViewController: assemblyFactory.rootModule.assembleViewController()!)
//        UIApplication.shared.keyWindow?.rootViewController = rootVC
        

        guard
                let window = UIApplication.shared.keyWindow,
                let _ = window.rootViewController
                else {
            return
        }

//        rootVC.view.frame = rootViewController.view.frame
//        rootVC.view.layoutIfNeeded()
        Bundle.swizzleLocalization()
        window.rootViewController = rootVC
//        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
//
//        })
    }
    
}
