//
//  lematiseText.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 17-12-22.
//  Copyright © 2017-2019 Alexandre Gaubil. All rights reserved.
//

import Foundation

func lemmatize(sentence: String) -> String {
    let tagger = NSLinguisticTagger(tagSchemes: [.lemma], options: 0)
    tagger.string = sentence
    let range = NSMakeRange(0, sentence.utf16.count)
    let options: NSLinguisticTagger.Options = [.omitWhitespace, .omitPunctuation]
    var lemmatizedText = ""
    
    if #available(iOS 11.0, *) {
        tagger.enumerateTags(in: range, unit: .word, scheme: .lemma, options: options) { (tag, tokenRange, stop) in
            let word = (sentence as NSString).substring(with: tokenRange)
            if let lemma = tag?.rawValue {
                //Add a whitespace before adding the lemma only if the text is not empty (aka: not before the first word)
                if lemmatizedText != "" {
                    lemmatizedText += " "
                }
                lemmatizedText += lemma
            } else {
                //Add a whitespace before adding the word only if the text is not empty (aka: not before the first word)
                if lemmatizedText != "" {
                    lemmatizedText += " "
                }
                lemmatizedText += word
            }
        }
    } else {
        print("Not running iOS 11: impossible to lematise text")
    }
    
    lemmatizedText = lemmatizedText.lowercased()
    
    lemmatizedText = replaceCommonMistakes(text: lemmatizedText)
    
    print("lemmatized Text = \(lemmatizedText)")
    
    return lemmatizedText
}
