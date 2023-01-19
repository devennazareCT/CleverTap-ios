//
//  AppDelegate.swift
//  Clevertap-ios
//
//  Created by Deven Nazare on 23/07/22.
//

import UIKit
import CleverTapSDK
import UserNotifications
@main
class AppDelegate: UIResponder, UIApplicationDelegate ,UNUserNotificationCenterDelegate{



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

       CleverTap.autoIntegrate()
        CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
        print("CleverTap SDK Initialized");
        registerForPush()

        let defaults = UserDefaults.standard
        print(UserDefaults.standard.bool(forKey: "Login"));
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! HomeView
      
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    func registerForPush() {
          // Register for Push notifications
          UNUserNotificationCenter.current().delegate = self
          // request Permissions
          UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert], completionHandler: {granted, error in
              if granted {
                  DispatchQueue.main.async {
                      UIApplication.shared.registerForRemoteNotifications()
                  }
              }
          })
      }
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//    func application(application: UIApplication,
//                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
//        CleverTap.sharedInstance()?.setPushToken(deviceToken as Data)
//        print("Device token is ",deviceToken as Data)
//    }
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                   didReceive response: UNNotificationResponse,
//                                   withCompletionHandler completionHandler: @escaping () -> Void) {
//           
//           NSLog("%@: did receive notification response: %@", self.description, response.notification.request.content.userInfo)
//           completionHandler()
//       }
//    
//       
//       func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                   willPresent notification: UNNotification,
//                                   withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//           
//           NSLog("%@: will present notification: %@", self.description, notification.request.content.userInfo)
//           CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: notification.request.content.userInfo)
//           completionHandler([.badge, .sound, .alert])
//       }
//       
//       func application(_ application: UIApplication,
//                        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
//                        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//           NSLog("%@: did receive remote notification completionhandler: %@", self.description, userInfo)
//           completionHandler(UIBackgroundFetchResult.noData)
//       }
       
    
    
    
    private func application(application: UIApplication,
                        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
//           CleverTap.sharedInstance()?.setPushToken(deviceToken as Data)
           print("Device token is ",deviceToken as Data)
       }
      func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("%@: failed to register for remote notifications: %@", self.description, error.localizedDescription)
      }
       
      //Background
      func userNotificationCenter(_ center: UNUserNotificationCenter,
                    didReceive response: UNNotificationResponse,
                    withCompletionHandler completionHandler: @escaping () -> Void) {
        //CleverTap.sharedInstance()?.recordNotificationClickedEvent(withData: response.notification.request.content.userInfo)
          
          CleverTap.sharedInstance()!.handleNotification(withData: response.notification.request.content.userInfo)
        completionHandler()
         
      }
       
      // Foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                    willPresent notification: UNNotification,
                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        NSLog("%@: will present notification: %@", self.description, notification.request.content.userInfo)
        CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: notification.request.content.userInfo)
        completionHandler([.badge, .sound, .alert])
      }
       
      //Push Notification Callback
      func pushNotificationTapped(withCustomExtras customExtras: [AnyHashable : Any]!) {
        print("Push Notification Tapped with Custom Extras: \(customExtras)");
      }
       
      //Manually Enable Support for Universal (Deep) Link Tracking
      func application(application: UIApplication, openURL url: NSURL,
               sourceApplication: String?, annotation: AnyObject) -> Bool {
        CleverTap.sharedInstance()?.handleOpen(url as URL, sourceApplication: sourceApplication)
        //handle the URL manually
        return true
      }
}

