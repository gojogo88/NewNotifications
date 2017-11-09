//
//  ViewController.swift
//  NewNotifications
//
//  Created by Jonathan Go on 2017/06/25.
//  Copyright © 2017 Appdelight. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Request permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            
            if granted {
                print("Notification access granted.")
            } else {
                print(error?.localizedDescription)
            }
        })
    }

    @IBAction func notifyButtonTapped(_ sender: UIButton) {

        scheduleNotification(inSeconds: 5, completion: {success in
            if success  {
                print("successfully scheduled notification")
            } else {
                print("Error scheduling notification")
            }
        })
        
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> () ) {
        
        //add an attachment
        let myImage = "rick_grimes"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else  {
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
            
        let notif = UNMutableNotificationContent()
        
        //only for extension
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "New Notification"
        notif.subtitle = "These are great!"
        notif.body = "The new notification in ios10 are what I've been looking for!"
        
        notif.attachments = [attachment]
        
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            if error != nil {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
            
        })
    }
}

