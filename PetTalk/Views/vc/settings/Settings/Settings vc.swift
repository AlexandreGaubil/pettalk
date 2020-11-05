//
//  SettingsViewController.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 17-09-16.
//  Copyright © 2017-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit
import MessageUI
import FirebaseAnalytics

class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var userNameTextFieldInput: UITextField!
    @IBOutlet weak var colorSegmentedControl: UISegmentedControl!
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var petNameTextField: UITextField!
    @IBOutlet weak var aboutButton: UIBarButtonItem!
    @IBOutlet weak var learnMoreButton: UIButton!
    @IBOutlet weak var contactSupport: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //Labels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var youLabel: UILabel!
    @IBOutlet weak var yourPetLabel: UILabel!
    @IBOutlet weak var helpDevLabel: UILabel!
    
    @IBAction func userNameTFDidEndOnExit(_ sender: Any) {
        if userNameTextFieldInput.text != "" {
            Defaults.set(userNameTextFieldInput.text, forKey: UserDefaultsKeys.userName)
            synchroniseGlobalInformation()
        } else {
            userNameTextFieldInput.text = globalInformation.userName
        }
    }
    @IBAction func petNameTextFieldDidEndOnEdit(_ sender: Any) {
        if petNameTextField.text != "" {
            Defaults.set(petNameTextField.text, forKey: UserDefaultsKeys.petName)
            synchroniseGlobalInformation()
        } else {
            petNameTextField.text = Defaults.string(forKey: UserDefaultsKeys.petName)
        }
    }
    @IBAction func userGenderSC(_ sender: Any) {
        switch colorSegmentedControl.selectedSegmentIndex {
        case 0: Defaults.set(Colors.blue, forKey: UserDefaultsKeys.color)
        case 1: Defaults.set(Colors.pink, forKey: UserDefaultsKeys.color)
        default: break
        }
        synchroniseGlobalInformation()
    }
    @IBAction func swipeDown(_ sender: Any) {
        userNameTextFieldInput.resignFirstResponder()
        petNameTextField.resignFirstResponder()
    }
    @IBAction func tapGesture(_ sender: Any) {
        userNameTextFieldInput.resignFirstResponder()
        petNameTextField.resignFirstResponder()
    }
    @IBAction func genderValueChanged(_ sender: Any) {
        switch colorSegmentedControl.selectedSegmentIndex {
        case 0:
            Defaults.set(Colors.blue, forKey: UserDefaultsKeys.color)
        case 1:
            Defaults.set(Colors.pink, forKey: UserDefaultsKeys.color)
        default: break
        }
        Analytics.logEvent("color_set", parameters: ["color": Defaults.string(forKey: UserDefaultsKeys.color) ?? "unknown color"])
        synchroniseGlobalInformation()
        //Change buttons color for user's gender
        if globalInformation.color == Colors.blue {
            contactSupport.backgroundColor = globalUIVariables.colorUserBoy
            learnMoreButton.backgroundColor = globalUIVariables.colorUserBoy
            aboutButton.tintColor = globalUIVariables.colorUserBoy
            colorSegmentedControl.tintColor = globalUIVariables.colorUserBoy
            self.navigationController?.navigationBar.tintColor = globalUIVariables.colorUserBoy
            self.view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 1, blue: 1, alpha: 1)
        } else {
            contactSupport.backgroundColor = globalUIVariables.colorUserGirl
            learnMoreButton.backgroundColor = globalUIVariables.colorUserGirl
            aboutButton.tintColor = globalUIVariables.colorUserGirl
            colorSegmentedControl.tintColor = globalUIVariables.colorUserGirl
            self.navigationController?.navigationBar.tintColor = globalUIVariables.colorUserGirl
            self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9490196078, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set navigation titles to large
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        
        learnMoreButton.setTitleColor(UIColor.white, for: .normal)
        contactSupport.setTitleColor(UIColor.white, for: .normal)
        learnMoreButton.layer.cornerRadius = 5
        contactSupport.layer.cornerRadius = 5
        //Setup fonts
        let preferedFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        nameLabel.font = preferedFont
        colorLabel.font = preferedFont
        petNameLabel.font = preferedFont
        youLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title2)
        yourPetLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title2)
        helpDevLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title2)
        userNameTextFieldInput.font = preferedFont
        petNameTextField.font = preferedFont
        donateButton.titleLabel?.font = preferedFont
        learnMoreButton.titleLabel?.font = preferedFont
        contactSupport.titleLabel?.font = preferedFont
        colorSegmentedControl.setTitleTextAttributes([NSAttributedStringKey.font:preferedFont], for: .normal)
        aboutButton.setTitleTextAttributes([NSAttributedStringKey.font:preferedFont], for: .normal)
        
        
        //Change buttons color for user's gender
        if globalInformation.color == Colors.blue {
            contactSupport.backgroundColor = globalUIVariables.colorUserBoy
            learnMoreButton.backgroundColor = globalUIVariables.colorUserBoy
            aboutButton.tintColor = globalUIVariables.colorUserBoy
            colorSegmentedControl.tintColor = globalUIVariables.colorUserBoy
            self.navigationController?.navigationBar.tintColor = globalUIVariables.colorUserBoy
            self.view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 1, blue: 1, alpha: 1)
        } else {
            contactSupport.backgroundColor = globalUIVariables.colorUserGirl
            learnMoreButton.backgroundColor = globalUIVariables.colorUserGirl
            aboutButton.tintColor = globalUIVariables.colorUserGirl
            colorSegmentedControl.tintColor = globalUIVariables.colorUserGirl
            self.navigationController?.navigationBar.tintColor = globalUIVariables.colorUserGirl
            self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9490196078, alpha: 1)
        }
        
        userNameTextFieldInput.text = globalInformation.userName
        petNameTextField.text = globalInformation.petName
        
        let gender = globalInformation.color
        switch gender {
        case Colors.blue?: colorSegmentedControl.selectedSegmentIndex = 0
        case Colors.pink?: colorSegmentedControl.selectedSegmentIndex = 1
        default:
            colorSegmentedControl.selectedSegmentIndex = 0
            Defaults.set(Colors.blue, forKey: UserDefaultsKeys.color)
        }
    }
    
    @IBAction func contactSupportButton(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        let versionText = "App version: " + String(NSObject.version())
        let systemVersion = "iOS version: " + UIDevice.current.systemVersion
        let deviceType = "Device used: " + UIDevice.current.modelName
        mailComposerVC.setToRecipients(["pettalkhelp@gmail.com"])
        mailComposerVC.setSubject("Support request")
        mailComposerVC.setMessageBody(versionText + "\n" + systemVersion + "\n" + deviceType, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let alertView = UIAlertController(title: "Error contacting support", message: "Sorry, your device was unable to email support. Please try again a bit later or email pettalkhelp@gmail.com directly.", preferredStyle: .alert)
        let action = UIAlertAction(title: TextForAlerts.ok, style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
