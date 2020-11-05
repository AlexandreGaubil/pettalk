//
//  Lookup exact match.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-01-27.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit
import Firebase //TODO: check if requiered

func lookupExactMatch() -> String {

    for child in arrayOfPreviousMessages {
        if let text = child["text"] {
            if globalStateMachine.lemmatizedTextMessage == text { return child["tag"]! }
        }
    }
    return "noMatch"
}
