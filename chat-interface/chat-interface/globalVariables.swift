//
//  globalVariables.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-01-05.
//  Copyright © 2018 Alexandre Gaubil. All rights reserved.
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

var UIDefaults = GlobalUI()

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
    var color = UserDefaults.standard.string(forKey: "color")
    var userName = UserDefaults.standard.string(forKey: "name")
    var petName = UserDefaults.standard.string(forKey: "petName")
    var petSpecies = UserDefaults.standard.string(forKey: "petSpecies")
}

var globalInformation = GlobalInformation()

func synchroniseGlobalInformation() {
    globalInformation.petName = UserDefaults.standard.string(forKey: "petName")
    globalInformation.petSpecies = UserDefaults.standard.string(forKey: "petSpecies")
    globalInformation.userName = UserDefaults.standard.string(forKey: "name")
    globalInformation.color = UserDefaults.standard.string(forKey: "color")
}
