//
//  State machine vars.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 2018-05-26.
//  Copyright © 2018-2019  Alexandre Gaubil. All rights reserved.
//

import Foundation

enum AnswerPreparationState {
    case wait
    case lemmatize
    case lookupExactMatch
    case lookupSimilarMatch
    case basicThemeAnalysis
    case randomAnswer
    case saveAsAnswer
}

var answerPrepState : AnswerPreparationState = .wait

enum AnswerPreparationTransition {
    case next
    case match
    case partialMatch
    case noMatch
}

func allowTransition(from: AnswerPreparationState, withTransition: AnswerPreparationTransition) -> Bool {
    switch (from, withTransition) {
    case (.wait, .next), (.lemmatize, .next), (.lookupExactMatch, .match), (.lookupExactMatch, .noMatch), (.lookupSimilarMatch, .match), (.lookupSimilarMatch, .noMatch), (.basicThemeAnalysis, .match), (.basicThemeAnalysis, .partialMatch), (.basicThemeAnalysis, .noMatch), (.randomAnswer, .next), (.saveAsAnswer, .next):
        return true
    default:
        return false
    }
}

func changeState(from: AnswerPreparationState, withTransition:AnswerPreparationTransition) {
    if allowTransition(from: from, withTransition: withTransition) {
        switch (from, withTransition) {
        case (.wait, .next):
            callMethodForNewState(state: .lemmatize)
            answerPrepState = .lemmatize
        case (.lemmatize, .next):
            callMethodForNewState(state: .lookupExactMatch)
            answerPrepState = .lookupExactMatch
        case (.lookupExactMatch, .match), (.lookupSimilarMatch, .match), (.basicThemeAnalysis, .match), (.basicThemeAnalysis, .partialMatch), (.randomAnswer, .next) :
            callMethodForNewState(state: .saveAsAnswer)
            answerPrepState = .saveAsAnswer
        case (.lookupExactMatch, .noMatch):
            callMethodForNewState(state: .lookupSimilarMatch)
            answerPrepState = .lookupSimilarMatch
        case (.lookupSimilarMatch, .noMatch):
            callMethodForNewState(state: .basicThemeAnalysis)
            answerPrepState = .basicThemeAnalysis
        case (.basicThemeAnalysis, .noMatch):
            callMethodForNewState(state: .randomAnswer)
            answerPrepState = .randomAnswer
        case (.saveAsAnswer, .next):
            callMethodForNewState(state: .wait)
            answerPrepState = .wait
        default : break
        }
    }
}
