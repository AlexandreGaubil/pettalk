//
//  UserDefaults.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 2019-03-09.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import Foundation

let Defaults = UserDefaults.standard

struct UserDefaultsKeys {
    static let userName = "name"
    static let color = "color"
    static let petName = "petName"
    static let petSpecies = "petSpecies"
    static let alreadyAskedForRating = "alreadyAskedForRating"
    static let loggedIn = "loggedIn"
    static let lastLoggin = "lastLoggin"
    static let messages = "textMessages"
    static let sendersOfMessages = "sendersMessages"
    static let textForNotification = "textMessagesNotification"
    static let appAlreadyLaunchedOnce = "isAppAlreadyLaunchedOnce"
    static let askedForRating = "alreadyAskedForRating"
    static let numberOfMessages = "numberOfMessages"
    static let tagEntry = "tagEntry"
    static let notificationTime = "NotificationTime"
}

struct Colors {
    static let blue = "blue"
    static let pink = "pink"
}

struct Sender {
    static let user = "u"
    static let pet = "p"
}

struct TextForAlerts {
    static let ok = "OK"
}

struct FirebaseReferences {

}

struct CommonStrings {
    static let separatorLineIndicator = "#separator_line"
}
