//
//  SetupVC.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-01-04.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit
import FirebaseAnalytics

class SetupVC: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var colorSegmentedControl: UISegmentedControl!
    var previousValueOfAgeTextField = ""
    
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButtonAction(_ sender: Any) {
        saveAction()
    }
    
    func saveAction() {
        //Show popup alert
        if nameTextField.text == "" {
            let alert = UIAlertController(title: "Please enter your name", message: "Don't worry, this is only stored on your phone and is only used to make the conversation more personal.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: TextForAlerts.ok, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            Defaults.set(nameTextField.text!, forKey: UserDefaultsKeys.userName)
            switch colorSegmentedControl.selectedSegmentIndex {
            case 0:
                Defaults.set(Colors.blue, forKey: UserDefaultsKeys.color)
            case 1:
                Defaults.set(Colors.pink, forKey: UserDefaultsKeys.color)
            default:
                Defaults.set(Colors.blue, forKey: UserDefaultsKeys.color)
            }
            Analytics.logEvent("sign_up", parameters: nil)
            Analytics.logEvent("color_set", parameters: ["color": Defaults.string(forKey: UserDefaultsKeys.color) ?? "unknown color"])
            Defaults.set(true, forKey: UserDefaultsKeys.loggedIn)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let configCtrl = sb.instantiateViewController(withIdentifier: "ConversationVC")
            self.navigationController?.pushViewController(configCtrl, animated: true)
            
            //Set value of globalInformation, setup AFINN, etc.
            InitialiseApp()
            synchroniseGlobalInformation()
            defaults.synchronize()
            DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 0.1)) {
                if defaults.string(forKey: UserDefaultsKeys.petSpecies) == "cat" {
                    saveMessage(text: "Hello! 😸 How are you " + Defaults.string(forKey: UserDefaultsKeys.userName)! + "?", sentBy: Sender.pet)
                } else {
                    saveMessage(text: "Hello! 🐶 How are you " + Defaults.string(forKey: UserDefaultsKeys.userName)! + "?", sentBy: Sender.pet)
                }
            }
        }
    }
    
    @IBAction func enterActionName(_ sender: Any) {
        nameTextField.resignFirstResponder()
        saveAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.becomeFirstResponder()
        navigationItem.title = "Your information"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let alreadyLogged = ```````````                                                                                                                                                                                                                                 Defaults.bool(forKey: UserDefaultsKeys.loggedIn)
        if alreadyLogged {
            self.dismiss(animated: true, completion: nil)
        }
        saveButton.backgroundColor = globalUIVariables.colorUserBoy
        saveButton.setTitleColor(UIColor.white, for: .normal)
        saveButton.layer.cornerRadius = 5
    }
}
