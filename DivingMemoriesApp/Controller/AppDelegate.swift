//
//  AppDelegate.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/10/18.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseMessaging
import UserNotificationsUI
import IQKeyboardManagerSwift
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Log用
        print("AppDelegate_didFinishLaunchingWithOptions_Start******************************")
        
        
        //Firebaseを使うため必要
        FirebaseApp.configure()
        
        
        
        //キーボードが上がったらViewもあげるもの----------------------------------------------------------
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        //キーボードが上がったらViewもあげるもの----------------------------------------------------------
        
        
        
        //広告に必要
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        
        
        
        
        if #available(iOS 10.0, *) {
            
            
            
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler:{_, _ in })
        }else{
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert,.badge, .sound ], categories: nil)
            
            application.registerUserNotificationSettings(settings)
            
            
        }
        
        application.registerForRemoteNotifications()
        
        
        
        return true
    }
    
    //プッシュ通知受信
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        //Log用
        print("AppDelegate_didReceiveRemoteNotification_Start***********************")
        
        
        if let messageID = userInfo["gcm.message_id"]{
            print("MassageIDは\(messageID)")
        }
        print(userInfo)
        
        
        print("AppDelegate_didReceiveRemoteNotification_End***********************")
    }
    
    
    //バックグラウンドにある時に受信処理
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        //Log用
        print("AppDelegate_didReceiveRemoteNotification_Start*********************************")
        
        
        if let messageID = userInfo["gcm.message_id"]{
            print("MassageIDは\(messageID)")
        }
        print(userInfo)
        print("AppDelegate_didReceiveRemoteNotification_End*********************************")
        
        
        
        
        
        print("AppDelegate_didFinishLaunchingWithOptions_End******************************")
    }
    
}


//アプリがフォアグランドに来た時に呼ばれるメソッド
@available(iOS 14.0, *)
func UIUSerNotficationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
    print("AppDelegate_UNUserNotificationCenter(フォア)_Start*********************************")
    let userinfo = notification.request.content.userInfo
    
    if let messageID = userinfo["gcm.message_id"] {
        
        print("MassageIDは\(messageID)")
    }
    
    print(userinfo)
    completionHandler([.badge,.sound,.banner])
    
    print("AppDelegate_UNUserNotificationCenter(フォア)_End*********************************")
    
}


//バックグラウンドに来た時に通知をタップ後、アプリが起動したら呼ばれる
@available(iOS 14.0, *)
func UIUSerNotficationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
    print("AppDelegate_UNUserNotificationCenter(バック)_Start*********************************")
    
    let userinfo = response.notification.request.content.userInfo
    
    if let messageID = userinfo["gcm.message_id"] {
        
        print("MassageIDは\(messageID)")
    }
    
    print(userinfo)
    completionHandler([.badge,.sound,.banner])
    
    
    
    
    
    
    
    
    
    
    
    
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
    
    
    
    print("AppDelegate_UNUserNotificationCenter(バック)_End*********************************")
    
}

