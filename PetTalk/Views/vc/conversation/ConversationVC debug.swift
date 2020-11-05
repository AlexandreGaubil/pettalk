//
//  ConversationVC debug.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 2018-05-27.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit
import MessageUI

extension ConversationViewController {
    
    ///Write to support for beta testers
    func captureScreen() -> UIImage {
        var window: UIWindow? = UIApplication.shared.keyWindow
        window = UIApplication.shared.windows[0]
        UIGraphicsBeginImageContextWithOptions(window!.frame.size, window!.isOpaque, 0.0)
        window!.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
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
        let alertView = createDismissableAlert(title: "Could not contact support", text: "Sorry, your device was not able to send the email to support. Please try again a bit later.", buttonText: TextForAlerts.ok)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func sendEmailToSupport() {
        let screenshot = UIImagePNGRepresentation(captureScreen())
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
            mailComposeViewController.addAttachmentData(screenshot!, mimeType: "image/jpeg", fileName: "Screenshot")
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    
    
    ///Test responsiveness of app when a lot of messages
    enum typeOfMessagesToAdd {
        case message
        case image
        case both
    }
    func addImagesAndMessages(type: typeOfMessagesToAdd) {
        switch type {
        case .message:
            for i in 0...300 {
                displayNewMessage(text: "Hello! How are you?", sentBy: Sender.user)
                print(i)
            }
            
        case .image:
            for i in 0...20 {
                displayRandomImage()
                print("Image: \(i)")
            }
            
        case .both:
            for i in 0...300 {
                displayNewMessage(text: "Hello! How are you?", sentBy: Sender.user)
                print(i)
            }
            for i in 0...20 {
                displayRandomImage()
                print("Image: \(i)")
            }
        }
    }
    
    
    
    ///Method for screenshots for App Store
    func prepareAppForAppStoreScreenshot() {
        //Remove messages
         for view in self.scrollView.subviews {
         view.removeFromSuperview()
         }
         let arrayMess = ["Hey!", "Hi! How are you?", "I'm good, thanks. What about you? How was your day?", "It was great! I had fun 💤 today. And you?", "Haha! 😝 I was at school all day", "Was it fun?", "Yup! I played ⚽️ with my friends, and we won!", "That's so cool!", "#IMG6", "Oh, he's so cute!"]
         let usersMe = [ "u", "p", "u", "p", "u", "p", "u", "p", "p", "u"]
         for i in 0...arrayMess.count - 1 {
         displayNewMessage(text: arrayMess[i], sentBy: usersMe[i])
         }
    }
    
}
