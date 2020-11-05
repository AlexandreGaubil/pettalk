//
//  CleanText.swift
//  PetTalkTests
//
//  Created by Alexandre Gaubil on 2018-05-26.
//  Copyright © 2018 Alexandre Gaubil. All rights reserved.
//

import XCTest

class CleanText: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func timeToSaveMessage() {
        let message = "This is a very long and weird sentence. It has personal names such as Tim Cook, places such as the Eiffel Tower, and addresses such as 371 avenue Metcalfe, Westmount, QC. Please remove the next hashtag symbol: #."
        self.measure {
            saveMessage(text: message, sentBy: "u")
        }
    }
    
    func cleanText() {
        // This is an example of a performance test case.
        let sentenceToClean = "This is a very long and weird sentence. It has personal names such as Tim Cook, places such as the Eiffel Tower, and addresses such as 371 avenue Metcalfe, Westmount, QC. Please remove the next hashtag symbol: #."
        var cleanedText = sentenceToClean
        self.measure {
            cleanedText = removeNames(text: sentenceToClean)
            cleanedText = lemmatize(sentence: cleanedText)
        }
        XCTAssert(cleanedText == "this be a very long and weird sentence it have personal name such as #personalname place such as the eiffel tower and address such as 371 avenue #placename #placename qc please remove the next hashtag symbol")
    }
    
}
