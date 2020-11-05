//
//  Sentiment analysis.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-02-25.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import Foundation

func sentimentAnalysis() -> AnswerPreparationTransition {

    let sentiment = evaluateSentiment(text: globalStateMachine.lemmatizedTextMessage)

    if sentiment > 2 { //POSITIVE
        globalStateMachine.tag = "positive"
        saveToFirebase(text: globalStateMachine.lemmatizedTextMessage, tag: "positive", textOriginal: globalStateMachine.textMessage)
        return .partialMatch

    } else if sentiment < -2 { //NEGATIVE
        globalStateMachine.tag = "negative"
        saveToFirebase(text: globalStateMachine.lemmatizedTextMessage, tag: "negative", textOriginal: globalStateMachine.textMessage)
        return .partialMatch

    } else if sentiment > -2 {  //NEUTRAL
        globalStateMachine.tag = "neutral"
        saveToFirebase(text: globalStateMachine.lemmatizedTextMessage, tag: "neutral", textOriginal: globalStateMachine.textMessage)
        return .noMatch

    }
    return .noMatch
}

///Func to evalute sentiment, returns a Double (+ : happy; - : unhappy)
func evaluateSentiment(text: String) -> Double {
    var sentimentValue = 0.0
    //let localText = text

    //for word in localText.components(separatedBy: " ") {
    for word in text.components(separatedBy: " ") {
        if (AFINNData[word] != nil) { sentimentValue += Double(Int(AFINNData[word]!)) }
    }

    return sentimentValue
}
