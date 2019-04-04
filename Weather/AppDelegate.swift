//
//  AppDelegate.swift
//  Weather
//
//  Created by ZZCM on 2019/3/27.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       let entity = JPUSHRegisterEntity()
        entity.types = Int(JPAuthorizationOptions.alert.rawValue|JPAuthorizationOptions.badge.rawValue|JPAuthorizationOptions.sound.rawValue)
        // Override point for customization after application launch.
       JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
}

extension AppDelegate: JPUSHRegisterDelegate {
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
       let handler = UNNotificationPresentationOptions(rawValue: UNNotificationPresentationOptions.alert.rawValue|UNNotificationPresentationOptions.sound.rawValue|UNNotificationPresentationOptions.badge.rawValue)
        completionHandler(Int(handler))
        
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        <#code#>
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
        <#code#>
    }
    
    
    
}
