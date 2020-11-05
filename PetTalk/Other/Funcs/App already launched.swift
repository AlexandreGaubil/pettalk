//
//  AppAlreadyLaunchedFunc.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 17-10-04.
//  Copyright © 2017-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

///Function to check if this is the first time the user opens this app
/// - Returns: Bool: true if app was already launched, false if it is the first launch of the app
func isAppAlreadyLaunchedOnce() -> Bool {
    
    if Defaults.string(forKey: UserDefaultsKeys.appAlreadyLaunchedOnce) != nil {
        return true
    } else {
        Defaults.set(true, forKey: UserDefaultsKeys.appAlreadyLaunchedOnce)
        return false
    }
}
