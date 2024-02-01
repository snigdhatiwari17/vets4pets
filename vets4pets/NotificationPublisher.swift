//
//  NotificationPublisher.swift
//  IA
//
//  Created by Snigdha Tiwari  on 01/08/23.
//

import Foundation
import UIKit
import UserNotifications

class NotificationPublisher: NSObject{
    
    func sendNotifications(title:String, subtitle: String, body: String, badge: Int?, delayInterval: Int?){
        
        let notificationContent = UNMutableNotificationContent() //singleton declared in class
        
        notificationContent.title = title
        notificationContent.subtitle = subtitle
        notificationContent.body = body
        
        var delayTimeTrigger: UNTimeIntervalNotificationTrigger?
        
        if let delayInterval = delayInterval {
            delayTimeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(delayInterval), repeats: false)
        }
        if let badge = badge {
            var currentBadgeCount = UIApplication.shared.applicationIconBadgeNumber
            currentBadgeCount += badge
            notificationContent.badge = NSNumber(integerLiteral: currentBadgeCount)
        }
        
        notificationContent.sound = UNNotificationSound.defaultCritical
        
        UNUserNotificationCenter.current().delegate = self
        
        let request = UNNotificationRequest(identifier: "vaccinations", content: notificationContent, trigger: delayTimeTrigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
        
    }

extension NotificationPublisher: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("notif about to be presented")
        completionHandler([.badge, .sound, .alert])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let identifier = response.actionIdentifier
        
        switch identifier {
        case  UNNotificationDismissActionIdentifier:
            print("notification dismissed")
            completionHandler()
            
        case UNNotificationDefaultActionIdentifier:
            print("user opened app from notification")
            completionHandler()
        default:
            print("default case")
        }
    }
    
}
