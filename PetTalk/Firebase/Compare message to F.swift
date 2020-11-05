//
//  compareWordByWord.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-01-04.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import Foundation
import Firebase

func compareWordByWord(string1: String, string2: String) -> Double {
    var diff: Double = 0

    let array1: [String] = string1.components(separatedBy: " ")
    let array2: [String] = string2.components(separatedBy: " ")

    //Compare each word of String1...
    for i in 0..<array1.count {
        var identical = false

        //...to each word of String2
        for j in 0..<array2.count {

            //If both words are identical, change identical to true
            if array1[i].isEqualToString(find: array2[j]) { identical = true }
        }
        if identical != true {
            diff += 1
        }
        identical = false
    }
    return diff
}

func compareToFirebase() -> String{
    var answerTag = ""
    var previousDifference: Double = 10000000000000000000000

    for i in 0..<arrayOfPreviousMessages.count {
        let dict = arrayOfPreviousMessages[i]
        let difference = compareWordByWord(string1: globalStateMachine.lemmatizedTextMessage, string2: dict["text"]!)
        if difference < 3 {
            if difference < previousDifference {
                answerTag = dict["tag"]!
                previousDifference = difference
                print("previousDiff > difference")
            }
        }
    }
    print("Difference = \(previousDifference)")
    if previousDifference < 3 {
        saveToFirebase(text: globalStateMachine.lemmatizedTextMessage, tag: answerTag, textOriginal: globalStateMachine.textMessage)
        return answerTag
    } else {
        return "noMatch"
    }
}
