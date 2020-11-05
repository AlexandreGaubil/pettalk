//
//  searchFirebaseForTag.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-01-13.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import Foundation
import Firebase

func searchFirebaseForTag(tag: String, word: String?) {
    var tree = globalStateMachine.tag
    var answers : Dictionary<Int, String> = [0:"test"]
    tree = tree.replacingOccurrences(of: ":", with: "/")

    let dbRef = Database.database().reference().child("answers/default")
    dbRef.observeSingleEvent(of: .value) { (snapshot) in
        answers = snapshot.value as! Dictionary<Int, String>
    }

    let randomNumber = Int(arc4random_uniform(UInt32(answers.count)))
    globalStateMachine.answer = answers[randomNumber]!

    if globalInformation.petSpecies == "cat" {
        globalStateMachine.answer = globalStateMachine.answer.replacingOccurrences(of: "$animalEmoji", with: "🐱")
    } else if globalInformation.petSpecies == "dog" {
        globalStateMachine.answer = globalStateMachine.answer.replacingOccurrences(of: "$animalEmoji", with: "🐶")
    } else {
        globalStateMachine.answer = globalStateMachine.answer.replacingOccurrences(of: "$animalEmoji", with: "🐱")
    }

    globalStateMachine.answer = globalStateMachine.answer.replacingOccurrences(of: "$userName", with: globalInformation.userName!)
    if word != nil {
        globalStateMachine.answer = globalStateMachine.answer.replacingOccurrences(of: "$word", with: word!)
    }

}
