//
//  AppDelegate.swift
//  TheGrow
//  Created by Buzzware Tech on 11/05/2021.
//

import UIKit
import IQKeyboardManagerSwift
import LGSideMenuController
import FirebaseCore
import FirebaseMessaging
import FirebaseInstallations
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var deviceTokenForPushN = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        firebasePushNotifications()
        checkUserAlreadyLogin()
        IQKeyboardManager.shared.enable = true
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        Messaging.messaging().apnsToken = deviceToken
        print ("ashdgjasjda" ,  deviceToken )
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication,didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    
    
}

extension AppDelegate {
    
    func checkUserAlreadyLogin() {
        var storyboard :UIStoryboard!
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        if (CommonHelper.getCachedUserData()?.user_id != nil) {
            let controller = storyboard.instantiateViewController(identifier: "LGSideMenuController") as! LGSideMenuController
            self.window?.rootViewController = controller
        } else {
            let controller = storyboard.instantiateViewController(identifier: "LoginVC")
            self.window?.rootViewController = controller
        }
        self.window?.makeKeyAndVisible()
    }
    
    
    func firebasePushNotifications() {
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        deviceTokenForPushN = (" \(token ?? "")")
        print("FCM deviceTokenForPushN: \(deviceTokenForPushN )")
        UserDefaults.standard.set(deviceTokenForPushN, forKey: Constant.token_id)
        UserDefaults.standard.synchronize()
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().delegate = self
        registerForPushNotifications()
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
                print("Permission granted: \(granted)")
                guard granted else { return }
                self?.getNotificationSettings()
            }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
                NotificationCenter.default.addObserver(self, selector: #selector(self.refreshToken(notification:)) , name: .MessagingRegistrationTokenRefreshed, object: nil)
            }
        }
    }
    
    @objc func refreshToken(notification : NSNotification) {
        Installations.installations().installationID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result)")
            }
        }
    }
}

extension AppDelegate:UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if notification.request.identifier == "Local Notification Order" {
            print("Handling notifications with the Local Notification Identifier")
            center.removeDeliveredNotifications(withIdentifiers: [notification.request.identifier])
            center.removePendingNotificationRequests(withIdentifiers: [notification.request.identifier])
        }
        UIApplication.shared.applicationIconBadgeNumber = 0
        completionHandler(UNNotificationPresentationOptions([.badge,.banner,.sound]))
        let userInfo = notification.request.content.userInfo
        
        guard (userInfo["aps"] as? [String: AnyObject]) != nil else {
            completionHandler(UNNotificationPresentationOptions([.badge,.banner,.sound]))
            return
        }
        print ("the user info is " , userInfo )
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "Local Notification Order" {
            print("Handling notifications with the Local Notification Identifier")
            center.removeDeliveredNotifications(withIdentifiers: [response.notification.request.identifier])
            UIApplication.shared.applicationIconBadgeNumber = 0
            completionHandler()
        }
    }
    
    @objc func userNotify(){
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
                return
            }
        }
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                return
            }
        }
        
        let content = UNMutableNotificationContent() // Содержимое уведомления
        content.title = "TastyBox"
        content.body = "Your Order Ready please collect it now"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let date = Date(timeIntervalSinceNow: 1800)
        let triggerHourly = Calendar.current.dateComponents([.second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerHourly, repeats: true)
        let identifier = "Local Notification Order"
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        notificationCenter.delegate = self
    }
}







