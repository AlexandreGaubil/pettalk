//
//  AddPetSetupVC.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-01-04.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

class AddPetSetupVC: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonAction(_ sender: Any) {
        saveAction()
    }
    
    @IBAction func keyboardEnter(_ sender: Any) {
        saveAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.backgroundColor = globalUIVariables.colorUserBoy
        saveButton.setTitleColor(UIColor.white, for: .normal)
        saveButton.layer.cornerRadius = 5
        
        let alreadyLogged = Defaults.bool(forKey: "loggedIn")
        if alreadyLogged {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func saveAction() {
        //Show popup alert
        if nameTextField.text == "" {
            let alert = UIAlertController(title: "Please name your pet", message: "To continue, please give a name to your pet. This will make the conversation more personal.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: TextForAlerts.ok, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            Defaults.set(nameTextField.text!, forKey: "petName")
            Defaults.set("cat", forKey: "petSpecies")
            
            let sb = UIStoryboard(name: "ConfigScreen", bundle: nil)
            let configCtrl = sb.instantiateViewController(withIdentifier: "setupVC")
            self.navigationController?.pushViewController(configCtrl, animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
