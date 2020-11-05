//
//  saveMessageFunc.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 17-12-15.
//  Copyright © 2017-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

///Save message to UserDefaults
func saveMessage(text: String, sentBy: String){
    var n = Defaults.integer(forKey: UserDefaultsKeys.numberOfMessages)
    var sentByArray = Defaults.stringArray(forKey: UserDefaultsKeys.sendersOfMessages) ?? []
    var textArray = Defaults.stringArray(forKey: UserDefaultsKeys.messages) ?? []

    sentByArray.append(sentBy)
    textArray.append(text)
    //n = n + 1

    Defaults.set(sentByArray, forKey: UserDefaultsKeys.sendersOfMessages)
    Defaults.set(textArray, forKey: UserDefaultsKeys.messages)
    Defaults.set(n + 1, forKey: UserDefaultsKeys.numberOfMessages)
}


func saveNotificationMessage(text: String) {
    Defaults.set(text, forKey: UserDefaultsKeys.textForNotification)
}


func appendNotificationMessages() {
    let notifTime = Defaults.double(forKey: UserDefaultsKeys.notificationTime)
    if Date.timeIntervalSinceReferenceDate >= notifTime {
        let textNotification = Defaults.string(forKey: UserDefaultsKeys.textForNotification)
        if textNotification != nil {
            saveMessage(text: textNotification!, sentBy: Sender.pet)
            Defaults.set(nil, forKey: UserDefaultsKeys.textForNotification)
        }
    }
}
