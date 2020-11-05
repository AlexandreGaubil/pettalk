//
//  insertNames.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 2018-03-22.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

func insertNames(text: String) -> String {
    var answer = text
    
    answer = answer.replacingOccurrences(of: "!#petname", with: globalInformation.petName!)
    answer = answer.replacingOccurrences(of: "!#username", with: globalInformation.userName!)
    
    return answer
}
