//
//  AppDelegate.swift
//  clock
//
//  Created by imac-1681 on 2023/7/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]){
//            (granted,_) in
//            if granted {
//                print("true")
//            }else{
//                print("false")
//            }
//        }
//        UNUserNotificationCenter.current().delegate = self
//        return true
//    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // 設定 statusBar 為白色
            UIApplication.shared.statusBarStyle = .lightContent
            let options: UNAuthorizationOptions = [.alert, .badge]
            UNUserNotificationCenter.current().requestAuthorization(options: options) { isAllow, error in
                guard error == nil else{
                    print("接收通知，Error：\(String(describing: error?.localizedDescription))")
                    return
                }
                if isAllow{
                    print("使用者同意接收通知")
                } else{
                    print("使用者不同意接收通知")
                }
            }
            UNUserNotificationCenter.current().delegate = self
            return true
        }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
          completionHandler([.badge, .sound, .alert])
      }

}

