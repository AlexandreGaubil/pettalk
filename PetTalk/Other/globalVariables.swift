//
//  globalVariables.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-01-05.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

//UI
class GlobalUI {
    var fontSizeForiPad = 20
    var messagesMarginsForiPad = 40
    var messagesMarginsForiPhone = 20
    var colorUserBoy : UIColor = #colorLiteral(red: 0.05490196078, green: 0.5254901961, blue: 0.9960784314, alpha: 1) //13, 133, 254
    var colorUserGirl : UIColor = #colorLiteral(red: 1, green: 0.2, blue: 0.6039215686, alpha: 1) //255, 51, 154
    var messagesColorPet = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
    var screenWidth: CGFloat = 0
}

var globalUIVariables = GlobalUI()

//State Machine
struct GlobalStateMachine {
    var textMessage = ""
    var lemmatizedTextMessage = ""
    var answer = "Sorry, I did not understand"
    var timeLeftOnTimer: TimeInterval = 0
    var tag = "default"
    var timeStartOfTimer: TimeInterval = 0
    var timeEndOfTimer: TimeInterval = 0
    var differenceBetweenMessageAndFirebaseMessage = false
    var continueToDisplayAnswer = false
    var numberOfMessagesNotInEnglish = 0 //When =10, display UIAlert
    var word = ""
}

var globalStateMachine = GlobalStateMachine()

struct GlobalInformation {
    var color = Defaults.string(forKey: UserDefaultsKeys.color)
    var userName = Defaults.string(forKey: UserDefaultsKeys.userName)
    var petName = Defaults.string(forKey: UserDefaultsKeys.petName)
    var petSpecies = Defaults.string(forKey: UserDefaultsKeys.petSpecies)
}

var globalInformation = GlobalInformation()

func synchroniseGlobalInformation() {
    globalInformation.petName = Defaults.string(forKey: UserDefaultsKeys.petName)
    globalInformation.petSpecies = Defaults.string(forKey: UserDefaultsKeys.petSpecies)
    globalInformation.userName = Defaults.string(forKey: UserDefaultsKeys.userName)
    globalInformation.color = Defaults.string(forKey: UserDefaultsKeys.color)
}
