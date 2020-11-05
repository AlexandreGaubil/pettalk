//
//  Setup functions.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-02-03.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import os.log

func InitialiseApp() {
    downloadTags()
    initialiseAFINN()
    initialiseThemesWords()
    downloadAnswersArray()
    globalInformation = GlobalInformation()
}


var AFINNData : [String: Int] = [:]
var ThemesWords: [String: Array] = [:]
var AnswersArray : [String: [String]] = [:]
var errorWhileDecodingAFINN = false

///Download tags and messages from firebase
func downloadTags() {
    let dbRef = Database.database().reference().child("messages")
    dbRef.observeSingleEvent(of: .value) { (snapshot) in
        for message in snapshot.children{
            let msg = (message as! DataSnapshot).value as! Dictionary<String,String>//message as snapshot
            arrayOfPreviousMessages.append(msg)
        }
    }
}

///Save the array of AFINN words to AFINNData
func initialiseAFINN() {
    guard let url = Bundle.main.url(forResource: "AFINN", withExtension: "json") else {
        errorWhileDecodingAFINN = true
        print("There was an error while decoding the AFINN dataset. HUGE BUG!!!!")
        os_log("Error while decoding AFINN.json file.")
        return
    }

    AFINNData = try! JSONDecoder().decode([String: Int].self, from: Data(contentsOf: url))
}

func initialiseThemesWords() {
  guard let url = Bundle.main.url(forResource: "Themes", withExtension: "json") else {
      errorWhileDecodingAFINN = true
      print("There was an error while decoding the AFINN dataset. HUGE BUG!!!!")
      os_log("Error while decoding AFINN.json file.")
      return
  }

  ThemesWords = try! JSONDecoder().decode([String: Int].self, from: Data(contentsOf: url))
}

func downloadAnswersArray() {
    let dbRef = Database.database().reference().child("answers")
    dbRef.observeSingleEvent(of: .value) { (snapshot) in
        for message in snapshot.children{
            //print(message)
            let msg = (message as! DataSnapshot).value as! Dictionary<String, String>
            let ref = msg["name"]
            var newMSG: [String] = []
            for child in msg {
                if child.key != "name" {
                    newMSG.append(child.value)
                }
            }
            arrayOfAnswers[ref!] = newMSG
        }
    }
}
