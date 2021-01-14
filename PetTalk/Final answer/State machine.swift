//
//  State machine.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-01-27.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import Foundation

func callMethodForNewState(state: AnswerPreparationState) {
    switch state {
    case .wait: break


    case .lemmatize : //LEMMATIZE
        saveMessage(text: globalStateMachine.textMessage, sentBy: Sender.user)
        globalStateMachine.lemmatizedTextMessage = removeNames(text: globalStateMachine.textMessage)
        globalStateMachine.lemmatizedTextMessage = lemmatize(sentence: globalStateMachine.lemmatizedTextMessage)
        globalStateMachine.lemmatizedTextMessage = clearTextOfSymbols(text: globalStateMachine.lemmatizedTextMessage)
        //partsOfSpeech(for: globalStateMachine.textMessage)  //TBD: is it necessary?
        changeState(from: .lemmatize, withTransition: .next)


    case .lookupExactMatch: //EXACT MATCH
        let theme = lookupExactMatch()
        if theme == "noMatch" {
            changeState(from: .lookupExactMatch, withTransition: .noMatch)
        } else {
            globalStateMachine.tag = theme
            changeState(from: .lookupExactMatch, withTransition: .match)
        }


    case .lookupSimilarMatch:  //SIMILAR MATCH : not done TODO
        let tag = compareToFirebase()
        if tag == "noMatch" {
            changeState(from: .lookupSimilarMatch, withTransition: .noMatch)
        } else {
            globalStateMachine.tag = tag
            changeState(from: .lookupSimilarMatch, withTransition: .match)
        }


    case .basicThemeAnalysis:  //SENTIMENT ANALYSIS -> + or -
      let theme = themeAnalysis(text: globalStateMachine.lemmatizedTextMessage)
      if theme == nil {
        changeState(from: .basicThemeAnalysis, withTransition: sentimentAnalysis())
      } else {
        globalStateMachine.tag = theme ?? ""
        changeState(from: .basicThemeAnalysis, withTransition: .match)
      }



    case .randomAnswer:  //RANDOM ANSWER -> IMG
        globalStateMachine.tag = "#IMG"
        changeState(from: .randomAnswer, withTransition: .next)


    case .saveAsAnswer:  //SAVE ANSWER
        saveAsAnswer()
        changeState(from: .saveAsAnswer, withTransition: .next)
    }
}
