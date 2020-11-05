//
//  Part of speech.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-02-16.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import Foundation

class Speech {
    let tagger = NSLinguisticTagger(tagSchemes:[.tokenType, .language, .lexicalClass, .nameType, .lemma], options: 0)
    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
    var arrayVerbs : [String] = []
    var arrayNouns : [String] = []
    var arrayAdj : [String] = []
}

var speech = Speech()

func partsOfSpeech(for text: String) {
    speech.tagger.string = text
    let range = NSRange(location: 0, length: text.utf16.count)
    speech.tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: speech.options) { tag, tokenRange, _ in
        if let tag = tag {
            let word = (text as NSString).substring(with: tokenRange)
            if tag.rawValue == "Noun" {
                speech.arrayNouns.append(word)
            } else if tag.rawValue == "Verb" {
                speech.arrayVerbs.append(word)
            } else if tag.rawValue == "Adjective" {
                speech.arrayAdj.append(word)
            }
        }
    }
}
