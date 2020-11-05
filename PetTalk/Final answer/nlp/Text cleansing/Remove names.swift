//
//  Remove personnal names.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 2018-05-12.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

///Remove all personal information from the messages (names, cities, companies, etc)
func removeNames(text: String) -> String{
    let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)
    tagger.string = text
    
    let range = NSRange(location:0, length: text.utf16.count)
    let options: NSLinguisticTagger.Options = [.omitWhitespace, .joinNames, .omitPunctuation, .omitOther]
    let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]
    var arrayOfWords: [String] = []
    tagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options) { tag, tokenRange, stop in
        let name = (text as NSString).substring(with: tokenRange)
        arrayOfWords.append(name)
        if let tag = tag, tags.contains(tag) {
            switch tag {
            case .personalName:
                if globalInformation.userName!.lowercased().range(of: name.lowercased()) != nil {
                    arrayOfWords[arrayOfWords.count - 1] = "#userName"
                } else if name.lowercased().range(of: globalInformation.userName!.lowercased()) != nil {
                    arrayOfWords[arrayOfWords.count - 1] = "#userName"
                } else {
                    arrayOfWords[arrayOfWords.count - 1] = "#personalName"
                }
            case .placeName:
                arrayOfWords[arrayOfWords.count - 1] = "#placeName"
            case .organizationName:
                arrayOfWords[arrayOfWords.count - 1] = "#organizationName"
            default: break
            }
        }
    }
    return arrayOfWords.joined(separator: " ")
}
