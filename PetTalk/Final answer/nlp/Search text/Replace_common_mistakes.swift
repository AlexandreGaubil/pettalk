//
//  File.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 2019-03-09.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import Foundation

func replaceCommonMistakes(text: String) -> String {
    var textArray = text.components(separatedBy: " ")
    for i in 0...(textArray.count - 1) {
        for commonMistake in CommonMistakes.commonMistakes {
            if textArray[i] == commonMistake.key {
                textArray[i] = commonMistake.value
            }
        }
    }
    return textArray.joined(separator: " ")
}
