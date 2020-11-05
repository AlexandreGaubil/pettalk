//
//  Firebase vars.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-01-01.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

/// Create a storage reference from our storage service
var ref: DatabaseReference! = Database.database().reference()

///Array of messages IDs
var arrayOfPreviousMessages: [[String:String]] = []
var arrayOfAnswers: [String:[String]] = [:]

///Func to enable persistence and syncing of Firebase database
func setupFirebase() {
    Database.database().isPersistenceEnabled = true
    ref.keepSynced(true)
}
