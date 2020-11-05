//
//  Save as answer.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-02-25.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit
import os.log
import Firebase

func saveAsAnswer() {

    var arrayOfPossibilities = arrayOfAnswers[globalStateMachine.tag]

    if globalStateMachine.tag == "#IMG" {
        globalStateMachine.answer = "#IMG"
        changeState(from: .saveAsAnswer, withTransition: .next)

    } else {

        if arrayOfPossibilities == nil {
            globalStateMachine.answer = "😸"
            os_log("Array of possibilities was nil")
            arrayOfPossibilities = arrayOfAnswers["default"]
            var position = 0

            if arrayOfPossibilities?.count != 0 {
              //TODO: check if the separation of both cases is necessary
                if arrayOfPossibilities?.count != 1 {
                    position = randomIntFrom(start: 0, to: (arrayOfPossibilities?.count)! - 1)
                } else { position = 1 }
                globalStateMachine.answer = arrayOfPossibilities![position]
            } else { globalStateMachine.answer = "Hum... I didn't understand" }
            
            Analytics.logEvent("array_of_possibilities_was_nil", parameters: ["tag": globalStateMachine.tag, "text_of_user": globalStateMachine.textMessage])
            /*let post:[String : String] = [
                "tag": globalStateMachine.tag,
                "textOfUser" : globalStateMachine.textMessage
            ]
            DispatchQueue.global(qos: .background).async {
                ref.child("bug/ArrayOfPossibilitiesWasNil").childByAutoId().setValue(post)
            }*/
        } else {
            var position = 0
            if arrayOfPossibilities?.count != 0 {
                if arrayOfPossibilities?.count != 1 {
                    position = randomIntFrom(start: 0, to: (arrayOfPossibilities?.count)! - 1)
                } else { position = 0 }
                globalStateMachine.answer = arrayOfPossibilities![position]
            } else {
                globalStateMachine.answer = "Hum... I didn't understand"
            }
        }
        globalStateMachine.answer = insertNames(text: globalStateMachine.answer)
        DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 4)) {
            saveMessage(text: globalStateMachine.answer, sentBy: Sender.pet)
        }
    }
}
