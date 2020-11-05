//
//  ConsoleInfoFuncs.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-01-06.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import Foundation

func printBlockedTransition(withTransition: String) {
    print("There was a transition blocked from '\(String(describing: answerPrepState))' with the transition '\(withTransition)'.")
}

func printCurrentState() {
    print("Current state: \(String(describing: answerPrepState))")
}

func version() -> String {
    let dictionary = Bundle.main.infoDictionary!
    let version = dictionary["CFBundleShortVersionString"] as! String
    let build = dictionary["CFBundleVersion"] as! String
    return "\(version) build \(build)"
} 
