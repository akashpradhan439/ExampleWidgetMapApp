//
//  AppDelegate.swift

//
//  Created by CE Info on 24/07/18.
//  Copyright © 2022 Mappls. All rights reserved.
//

import UIKit
import MapplsAPICore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        MapplsAccountManager.setMapSDKKey("b340c78affb4b7985d8cd820405c03d2")
        MapplsAccountManager.setRestAPIKey("b340c78affb4b7985d8cd820405c03d2")
        MapplsAccountManager.setClientId("33OkryzDZsLl3oK3-y3-oVmAzZsGx95_J6Wi4-8GSKmiKNQrP63N9cf-b7LtqxG6kxlj3aL3RNGbGc4LG5xvaFNYAOXJ99gU")
        MapplsAccountManager.setClientSecret("lrFxI-iSEg8guc_qKASYZGSASKW-zZrW1mphvEHG770-sk4O09QOMnmAo91BaHs5-oI4OijwF0y40NwFZ4Sean6cVwY-RzcxEH_u23J3Ydk=")
        
        if let url = launchOptions?[.url] as? URL {
           handleDeepLink(url)
        }
        
        return true
    }
    
    func application(_ application: UIApplication,
                     performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        
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

    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        handleDeepLink(url)
        return true
    }

    func handleDeepLink(_ url: URL) {
        if let viewController = createViewController(for: url) {
            let vc = UINavigationController(rootViewController: viewController)
            window?.rootViewController = vc
        }
    }

    func createViewController(for url: URL) -> UIViewController? {
        if url.scheme == "widget-deeplink" {
            if let host = url.host {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitialVC") as! InitialVC
                
                vc.deeplink = host
                
                return vc
            }
        }
        return nil
    }

}

