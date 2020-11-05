//
//  saveToFirebase.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-01-01.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit
import Firebase

func saveToFirebase(text: String, tag: String, textOriginal: String) {
    let post:[String : String] = [
        "text": text,
        "tag":tag,
        "originalText":textOriginal
        ]
    ref.child("messages").childByAutoId().setValue(post)
}
