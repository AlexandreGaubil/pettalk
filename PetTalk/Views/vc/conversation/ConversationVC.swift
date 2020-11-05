//
//  ConversationViewController.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 17-09-17.
//  Copyright © 2017-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit
import Firebase
import MessageUI
import os.log
import StoreKit
//import Crashlytics


class ConversationViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate {

    //BUTTONS ----- BUTTONS ----- BUTTONS ----- BUTTONS ----- BUTTONS

    ///Text field where the user types a message
    @IBOutlet weak var textField: UITextField!
    ///Send Button
    @IBOutlet weak var sendButton: UIButton!
    ///Size of the screen
    let screenSize = UIScreen.main.bounds
    ///Scroll view to display messages
    @IBOutlet weak var scrollView: UIScrollView!
    ///Settings navigation bar button
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    ///Dock view
    @IBOutlet weak var dockView: UIView!
    ///Navigation bar for ConversationVC outlet
    @IBOutlet weak var navigationBar: UINavigationItem!
    ///Tap on scrollView: scroll to bottom
    @IBOutlet weak var reportButton: UIBarButtonItem!
    @IBAction func tapOnScrollView(_ sender: Any) {
        textField.resignFirstResponder()
        scrollToBottom(animated: true)
    }
    ///Swipe up gesture to remove keyboard from screen
    @IBAction func swipeUp(_ sender: Any) {
        textField.resignFirstResponder()
        scrollToBottom(animated: true)
    }
    @IBAction func textFieldEditingBegan(_ sender: Any) {
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.scrollToBottom(animated: true)
        }
    }
    @IBAction func textFieldEditingEnded(_ sender: Any) {
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.scrollToBottom(animated: true)
        }
    }
    @IBAction func sendButton(_ sender: Any) {
        sendAction()
    }
    @IBAction func keyboardSendButton(_ sender: Any) {
        sendAction()
    }
    @IBAction func reportButton(_ sender: Any) {
        addImagesAndMessages(type: .message)
    }

    ///Function to vibrate button on press
    @objc func tapped() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }

    func scrollToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: animated)
    }
    func reloadMessages(numberOfMessagesToReload: Int) {
        let nMessages: Int = (Defaults.stringArray(forKey: "textMessages") ?? []).count
        let lastNumberToReloadFrom = nMessages - numberOfMessagesToReload
        //Remove messages
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
        //Set scrollView size to 0
        scrollView.contentSize.height = 0
        //Reload messages
        let arrayOfMessages = Defaults.stringArray(forKey: "textMessages") ?? []
        let arrayOfSenders = Defaults.stringArray(forKey: "sendersMessages") ?? []
        var origin = lastNumberToReloadFrom
        if lastNumberToReloadFrom < 0 {
            origin = 0
        }
        for i in origin..<nMessages {
            let sender = arrayOfSenders[i]
            let text = arrayOfMessages[i]
            displayNewMessage(text: text, sentBy: sender)
            scrollView.sizeToFit()
        }
        scrollView.sizeToFit()
        scrollToBottom(animated: true)
    }


    ///SEND FUNCTIONS ----- SEND FUNCTIONS ----- SEND FUNCTIONS ----- SEND FUNCTIONS ----- SEND FUNCTIONS

    ///Send button function
    func sendAction() {
        if textField.text != "" {
            displayNewMessage(text: textField.text!, sentBy: Sender.user)
            Analytics.logEvent("send_message", parameters: nil)
            globalStateMachine.textMessage = textField.text!
            textField.text = ""
            globalStateMachine.lemmatizedTextMessage = lemmatize(sentence: globalStateMachine.textMessage)
            changeState(from: .wait, withTransition: .next)
            DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 4)) {
                if globalStateMachine.answer == "#IMG" {
                    self.displayRandomImage()
                } else {
                    self.displayNewMessage(text: globalStateMachine.answer, sentBy: Sender.pet)
                }
                if globalStateMachine.tag == "loves:pet" && Defaults.bool(forKey: UserDefaultsKeys.askedForRating) != true {
                    SKStoreReviewController.requestReview()
                    Defaults.set(true, forKey: UserDefaultsKeys.askedForRating)
                }
            }
            globalStateMachine.continueToDisplayAnswer = false
        }
    }

    ///Image
    func displayRandomImage() {
        let imagesURLArray : [String] = Defaults.array(forKey: "imagesArray") as! [String]
        let imageNumber = randomIntFrom(start: 0, to: (imagesURLArray.count - 1))
        print("Image : \(imageNumber)")
        saveMessage(text: "#IMG" + String(imageNumber), sentBy: Sender.pet)
        displayNewMessage(text: "#IMG" + String(imageNumber), sentBy: Sender.pet)
    }

    ///Function to create a new message label
    func displayNewMessage(text: String, sentBy: String){
        let newMessageView = createNewMessageBubble(text: text, sentBy: sentBy, widthScreen: Int(self.view.frame.width), scrollViewHeight: Int(scrollView.contentSize.height))

        self.scrollView.addSubview(newMessageView)
        scrollView.contentSize.height = globalCVVariables.scrollViewHeight
        //Scroll to bottom of UIScrollView
        let numberOfMessages = Defaults.integer(forKey: UserDefaultsKeys.numberOfMessages)
        if numberOfMessages > 7 {
            scrollToBottom(animated: true)
        } else if numberOfMessages < 7 {
            scrollToBottom(animated: false)
        }
        //Synchronise NSUserDefaults
        Defaults.synchronize()
    }



    ///OVERRIDE ----- OVERRIDE ----- OVERRIDE ----- OVERRIDE ----- OVERRIDE ----- OVERRIDE ----- OVERRIDE

    ///1 - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        reportButton.title = ""
        sendButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        sendButton.frame.size.width = (sendButton.titleLabel?.text?.width(withConstrainedHeight: 1000, font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)))!
        sendButton.widthAnchor.constraint(greaterThanOrEqualToConstant: (sendButton.titleLabel?.text?.width(withConstrainedHeight: 1000, font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)))!).isActive = true
        textField.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)

        //Check if app was already launched before, and if not, launch setupScreen
        if !(Defaults.bool(forKey: UserDefaultsKeys.loggedIn)) {
            Defaults.set(false, forKey: UserDefaultsKeys.tagEntry)
            let sb = UIStoryboard(name: "ConfigScreen", bundle: nil)
            let configCtrl = sb.instantiateViewController(withIdentifier: "WelcomeScreen")
            self.navigationController!.pushViewController(configCtrl, animated: false)
        }

        //Synchronise NSUserDefaults
        Defaults.synchronize()
        //Add vibration function to button
        sendButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)

        textField.returnKeyType = .send

        if UIDevice.current.userInterfaceIdiom == .pad {
            var frameRect = textField.frame
            frameRect.size.height = 50
            textField.frame = frameRect
            frameRect = sendButton.frame
            frameRect.size.height = 50
            sendButton.frame = frameRect
        }
    }

    ///2 - VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
        globalUIVariables.screenWidth = self.view.bounds.width
        navigationBar.title = globalInformation.petName
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
    }

    ///3 - VIEW DID APPEAR
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Add a separation line in conversation if over an hour ago
        if ((Float(Date.init().timeIntervalSinceReferenceDate) - Defaults.float(forKey: UserDefaultsKeys.lastLoggin)) > 3600)
            && ((Defaults.stringArray(forKey: UserDefaultsKeys.messages) ?? [CommonStrings.separatorLineIndicator])[(Defaults.stringArray(forKey: UserDefaultsKeys.messages) ?? [CommonStrings.separatorLineIndicator]).count - 1] != CommonStrings.separatorLineIndicator)
            && (Defaults.array(forKey: UserDefaultsKeys.messages)?.count ?? 0 > 2) {
            saveMessage(text: CommonStrings.separatorLineIndicator, sentBy: Sender.pet)
        }

        Defaults.set(Date.init().timeIntervalSinceReferenceDate, forKey: UserDefaultsKeys.lastLoggin)
        reloadMessages(numberOfMessagesToReload: 100)

        synchroniseGlobalInformation()
        settingsButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if globalInformation.color == Colors.blue {
            sendButton.setTitleColor(globalUIVariables.colorUserBoy, for: .normal)
            //To get rid of the pallid color of the button when is exited and re-entered
            settingsButton.tintColor = globalUIVariables.colorUserBoy
            scrollView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 1, blue: 1, alpha: 1)
            dockView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 1, blue: 1, alpha: 1)
            self.view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 1, blue: 1, alpha: 1)
        } else {
            sendButton.setTitleColor(globalUIVariables.colorUserGirl, for: .normal)
            //To get rid of the pallid color of the button when is exited and re-entered
            settingsButton.tintColor = globalUIVariables.colorUserGirl
            scrollView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9490196078, alpha: 1)
            dockView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9490196078, alpha: 1)
            self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9490196078, alpha: 1)
        }
        scrollToBottom(animated: false)

        checkForInternet()
        checkForUpdate()
    }

    ///4- ROTATION OR SPLIT VIEW
    override func didRotate(from : UIInterfaceOrientation) {
        reloadMessages(numberOfMessagesToReload: 100)
        self.view.setNeedsDisplay()
        scrollToBottom(animated: true)
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        globalUIVariables.screenWidth = self.view.bounds.width
    }

    ///5 - VIEW WILL DISAPPEAR
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textField.resignFirstResponder()
        scrollToBottom(animated: true)
        self.dismiss(animated: true, completion: nil)
    }

    ///MEMORY WARNING
    override func didReceiveMemoryWarning() {
        reloadMessages(numberOfMessagesToReload: 50)
        DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 0.25)) {
            self.scrollToBottom(animated: true)
        }
    }
}
