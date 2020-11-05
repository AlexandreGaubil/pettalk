//
//  conversation_view.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 17-09-17.
//  Copyright © 2017 Alexandre Gaubil. All rights reserved.
//

import UIKit

public class ChatInterfaceViewController: UIView, UITextFieldDelegate {
    
    ///Text field where the user types a message
    @IBOutlet weak var textField: UITextField!
    ///Send Button
    @IBOutlet weak var sendButton: UIButton!
    ///Size of the screen
    let screenSize = UIScreen.main.bounds
    ///Scroll view to display messages
    @IBOutlet weak var scrollView: UIScrollView!
    ///UserDefaults
    let defaults = UserDefaults.standard
    ///Dock view
    @IBOutlet weak var dockView: UIView!
    ///Tap on scrollView: scroll to bottom
    @IBAction func tapOnScrollView(_ sender: Any) {
        textField.resignFirstResponder()
        scrollToBottom(animated: true)
    }
    @IBAction func swipeUp(_ sender: Any) {
        textField.resignFirstResponder()
        //scrollToBottom(animated: true)
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
    @IBAction func sendButtonAction(_ sender: Any) {
        sendAction()
    }
    @IBAction func keyboardSendButtonAction(_ sender: Any) {
        sendAction()
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
        let nMessages: Int = defaults.integer(forKey: "numberOfMessages")
        let lastNumberToReloadFrom = nMessages - numberOfMessagesToReload
        //Remove messages
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
        //Set scrollView size to 0
        scrollView.contentSize.height = 0
        //Reload messages
        let arrayOfMessages = defaults.stringArray(forKey: "textMessages") ?? []
        let arrayOfSenders = defaults.stringArray(forKey: "sendersMessages") ?? []
        var origin = lastNumberToReloadFrom
        if lastNumberToReloadFrom < 0 {
            origin = 0
        }
        for i in origin..<nMessages {
            let sender = arrayOfSenders[i]
            let text = arrayOfMessages[i]
            //print("Sender \(sender) sent the message '\(text)'")
            displayNewMessage(text: text, sentBy: sender)
            scrollView.sizeToFit()
        }
        scrollView.sizeToFit()
        scrollToBottom(animated: true)
    }
    
    ///Send button function
    func sendAction() {
        if textField.text == "" {
            print("No text in textField: message was not sent")
        } else if textField.text != "" {
            displayNewMessage(text: textField.text!, sentBy: "u")
            textField.text = ""
        }
    }
    
    ///Image
    func displayNewImage() {
        let imagesURLArray : [String] = defaults.array(forKey: "imagesArray") as! [String]
        let imageNumber = randomIntFrom(start: 0, to: (imagesURLArray.count - 1))
        print("Image : \(imageNumber)")
        displayNewMessage(text: "#IMG" + String(imageNumber), sentBy: "p")
    }
    
    ///Function to create a new message label
    func displayNewMessage(text: String, sentBy: String){
        let newMessageView = createNewMessageBubble(text: text, sentBy: sentBy, widthScreen: Int(self.view.frame.width), scrollViewHeight: Int(scrollView.contentSize.height))
        
        self.scrollView.addSubview(newMessageView)
        scrollView.contentSize.height = globalCVVariables.scrollViewHeight
        //Scroll to bottom of UIScrollView
        let numberOfMessages = defaults.integer(forKey: "numberOfMessages")
        if numberOfMessages > 7 {
            scrollToBottom(animated: true)
        } else if numberOfMessages < 7 {
            scrollToBottom(animated: false)
        }
        //Synchronise NSUserDefaults
        defaults.synchronize()
    }
    
    
    
    ///OVERRIDE ----- OVERRIDE ----- OVERRIDE ----- OVERRIDE ----- OVERRIDE ----- OVERRIDE ----- OVERRIDE
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
    
    }
    
    ///1 - VIEW DID LOAD
    override public func viewDidLoad() {
        super.viewDidLoad()
        sendButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        sendButton.frame.size.width = (sendButton.titleLabel?.text?.width(withConstrainedHeight: 1000, font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)))!
        //print(sendButton.frame.size)
        sendButton.widthAnchor.constraint(greaterThanOrEqualToConstant: (sendButton.titleLabel?.text?.width(withConstrainedHeight: 1000, font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)))!).isActive = true
        textField.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        //Check if app was already launched before, and if not, launch setupScreen
        let alreadyLogged = UserDefaults.standard.bool(forKey: "loggedIn")
        if !alreadyLogged {
            defaults.set(false, forKey: "tagEntry")
            let sb = UIStoryboard(name: "ConfigScreen", bundle: nil)
            let configCtrl = sb.instantiateViewController(withIdentifier: "WelcomeScreen")
            self.navigationController!.pushViewController(configCtrl, animated: false)
        }
        //Synchronise NSUserDefaults
        defaults.synchronize()
        //Add vibration function to button
        sendButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        //Set the return key of keyboard to send
        textField.returnKeyType = .send
        //Change size of buttons if it is an iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            //adjust size for iPads
            //Change height of textField
            var frameRect = textField.frame
            frameRect.size.height = 50
            textField.frame = frameRect
            //Change height of button
            frameRect = sendButton.frame
            frameRect.size.height = 50
            sendButton.frame = frameRect
        }
    }
    
    ///2 - VIEW WILL APPEAR
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Remove messages to prevent odd looking interface on iPhone when app is relaunched
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
        UIDefaults.screenWidth = self.view.bounds.width
        navigationBar.title = globalInformation.petName
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
    }
    
    ///3 - VIEW DID APPEAR
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadMessages(numberOfMessagesToReload: 100)
        
        synchroniseGlobalInformation()
        settingsButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if globalInformation.color == "blue" {
            print("color reset")
            sendButton.setTitleColor(UIDefaults.colorUserBoy, for: .normal)
            //To get rid of the pallid color of the button when is exited and re-entered
            settingsButton.tintColor = UIDefaults.colorUserBoy
            scrollView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 1, blue: 1, alpha: 1)
            dockView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 1, blue: 1, alpha: 1)
            self.view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 1, blue: 1, alpha: 1)
        } else {
            sendButton.setTitleColor(UIDefaults.colorUserGirl, for: .normal)
            //To get rid of the pallid color of the button when is exited and re-entered
            settingsButton.tintColor = UIDefaults.colorUserGirl
            scrollView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9490196078, alpha: 1)
            dockView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9490196078, alpha: 1)
            self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9490196078, alpha: 1)
        }
        scrollToBottom(animated: false)
    }
    
    ///4- ROTATION OR SPLIT VIEW
    override public func didRotate(from : UIInterfaceOrientation) {
        reloadMessages(numberOfMessagesToReload: 100)
        
        self.view.setNeedsDisplay()
        scrollToBottom(animated: true)
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        UIDefaults.screenWidth = self.view.bounds.width
        //reloadMessages(numberOfMessagesToReload: 100)
    }
    
    ///5 - VIEW WILL DISAPPEAR
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //settingsButton.button selected = false
        //Resign first responder textfield
        textField.resignFirstResponder()
        scrollToBottom(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
