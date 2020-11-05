//
//  Notifications.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-02-24.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase

func setupNotification() {
    //Remove all previously added notifications
    let center = UNUserNotificationCenter.current()
    center.removeAllPendingNotificationRequests()
    
    var requestTrigger = UNTimeIntervalNotificationTrigger(timeInterval: (60*60*8), repeats: false)
    var messageFromPet = "How was your day? 😺"
    
    let hour = Calendar.current.component(.hour, from: Date()) + 8
    
    var timeIntervalForNotification = 8
    print("Hour = \(hour)")
    switch hour {
    case 1:
        timeIntervalForNotification += 6
        messageFromPet = "Your pet misses you!"
    case 2:
        timeIntervalForNotification += 5
        messageFromPet = "Come back and chat with me!"
    case 3:
        timeIntervalForNotification += 4
        messageFromPet = "Hey!"
    case 4:
        timeIntervalForNotification += 3
        messageFromPet = "Come talk with me!"
    case 5:
        timeIntervalForNotification += 2
        messageFromPet = "I miss you..."
    case 6:
        timeIntervalForNotification += 1
        messageFromPet = "I'm lonely"
    case 7:
        messageFromPet = "Can you come back please?"
    case 8:
        messageFromPet = "I hope you have a great day!"
    case 9:
        timeIntervalForNotification += -1
        messageFromPet = "So, how are you?"
    case 10:
        timeIntervalForNotification += -2
        messageFromPet = "Please come back to see me!"
    case 11:
        timeIntervalForNotification += -3
        messageFromPet = "😸👋"
    case 13:
        timeIntervalForNotification += -4
        messageFromPet = "How are you?"
    case 14:
        timeIntervalForNotification += 3
        messageFromPet = "Come on!"
    case 15:
        timeIntervalForNotification += 2
        messageFromPet = "I miss you"
    case 16:
        timeIntervalForNotification += 1
        messageFromPet = "Can you come back?"
    case 17:
        messageFromPet = "How did your day go?"
    case 18:
        messageFromPet = "How was your day?"
    case 19:
        messageFromPet = "Did you have fun?"
    case 20:
        timeIntervalForNotification += -3
        messageFromPet = "😸"
    case 21:
        timeIntervalForNotification += -2
        messageFromPet = "How was your day?"
    case 22:
        timeIntervalForNotification += -4
        messageFromPet = "Hey there!"
    case 23:
        timeIntervalForNotification += 8
        messageFromPet = "I love you!"
    case 24:
        timeIntervalForNotification += 7
        messageFromPet = "Hi!"
    default: break
    }
    
    print("TimeIntervalForNotification = \(timeIntervalForNotification)")
    timeIntervalForNotification = timeIntervalForNotification * 60 * 60 //put it in seconds
    requestTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeIntervalForNotification), repeats: false)
    
    let notifTime = Date.timeIntervalSinceReferenceDate + Double(timeIntervalForNotification)
    Defaults.set(notifTime, forKey: "NotificationTime")
    
    if globalInformation.petName != nil {  //Makes sure the user finished setting up the app
        let requestContent = UNMutableNotificationContent()
        requestContent.title = globalInformation.petName! + " has written to you!"        // insert your title
        //requestContent.subtitle = "From " + globalInformation.petName!  // insert your subtitle
        requestContent.body = messageFromPet // insert your body
        requestContent.badge = 1 // the number that appears next to your app
        requestContent.sound = UNNotificationSound.default()
        // Request the notification
        let request = UNNotificationRequest(identifier: "comeBackToChat", content: requestContent, trigger: requestTrigger)
        
        // Post the notification!
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
                let post:[String : String] = [
                    "typeOfError": "notificationDeliveryError",
                    "error" : String(describing: error),
                    "device": UIDevice.current.modelName
                ]
                ref.child("bug/error").childByAutoId().setValue(post)
            } else {
                saveNotificationMessage(text: messageFromPet)
                
            }
        }
    }
}
