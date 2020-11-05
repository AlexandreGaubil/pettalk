//
//  AlertVC.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 2018-03-01.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

func createNonDismissableAlert(title: String, text: String) -> UIAlertController {
    let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
    return alertVC
}

func createDismissableAlert(title: String, text: String, buttonText: String) -> UIAlertController {
    let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
    let button = UIAlertAction(title: buttonText, style: .default)
    alertVC.addAction(button)
    return alertVC
}
