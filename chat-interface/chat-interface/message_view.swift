//
//  message_view.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-02-27.
//  Copyright © 2018 Alexandre Gaubil. All rights reserved.
//

import UIKit
import os.log

class GlobalCVVariables {
    var scrollViewHeight: CGFloat = 0
}

var globalCVVariables = GlobalCVVariables()

func createNewMessageBubble(text: String, sentBy: String, widthScreen: Int, scrollViewHeight: Int) -> UIView {
    //IMAGES AND GIFS VS TEXT
    if text.contains("#IMG") {
        //print("Image")
        let imageCode = Int(text.dropFirst(4))
        if imageCode != nil {
            //print("Image was not nil")
            let imageView = displayImage(imageNumber: imageCode!, scrollViewHeight: scrollViewHeight, scrollViewWidth: widthScreen)
            return imageView
        } else {
            print("Corrupt image number in conversation history: \(String(describing: imageCode))")
            os_log("Error: corrupt image name saved in conversation history")
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            return view
        }
    }
    
    //print("Scroll view size: \(scrollViewHeight)")
    //print("width screen: \(widthScreen)")
    
    //FONT
    var fontOfMessage = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    if UIDevice.current.userInterfaceIdiom == .pad {
        if Int(fontOfMessage.pointSize) < UIDefaults.fontSizeForiPad {
            fontOfMessage = fontOfMessage.withSize(CGFloat(UIDefaults.fontSizeForiPad))
        }
    }
    //COORDINATES
    var xCoordinateMessage = returnxCoordinateOfMessage(sentBy: sentBy)  //Change value of xCoordinateMessage (value of message xCoord) depending on who sent the message
    var widthOfLabel = widthOfLabelFunc(sentBy: sentBy, scrollViewWidth: CGFloat(widthScreen), xCoordinate: xCoordinateMessage)  //Define the width of the label by taking the UIScrollView size and substracting 30
    let heightOfLabel = text.height(constraintedWidth: widthOfLabel, font: fontOfMessage)  //Height of the newMessageLabel, depending on the size of the text
    let widthOfLabelCheck = text.width(withConstrainedHeight: heightOfLabel, font: fontOfMessage)
    if widthOfLabelCheck < widthOfLabel {
        if sentBy == "u"{
            var margins = 0
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                // It's an iPad
                margins = UIDefaults.messagesMarginsForiPad
            default:
                margins = UIDefaults.messagesMarginsForiPhone
            }
            xCoordinateMessage = xCoordinateMessage + (Int(widthScreen) - margins - xCoordinateMessage - Int(widthOfLabelCheck))
            widthOfLabel = widthOfLabelCheck
        } else if sentBy == "p" {
            widthOfLabel = widthOfLabelCheck
        }
    }
    
    ///Label for the message to add
    let newMessageLabel = UILabel(frame: CGRect(x: CGFloat(3), y: CGFloat(3), width: widthOfLabel, height: heightOfLabel))
    let newMessageView = UIView(frame: CGRect(x: CGFloat(xCoordinateMessage), y: CGFloat(scrollViewHeight + 10), width: widthOfLabel + 6, height: heightOfLabel + 6))
    newMessageView.widthAnchor.constraint(equalToConstant: widthOfLabel + 6).isActive = true
    newMessageView.heightAnchor.constraint(equalToConstant: heightOfLabel + 6).isActive = true
    newMessageView.addSubview(newMessageLabel) //Add label to view
    newMessageLabel.font = fontOfMessage
    newMessageLabel.textAlignment = .natural
    newMessageLabel.numberOfLines = 0  //Set the number of lines to 0 to make sure the text in it's entirety can be seen
    newMessageLabel.text = text
    newMessageLabel.isUserInteractionEnabled = true
    newMessageLabel.textColor = textColorOfMessage(sentBy: sentBy)
    newMessageView.clipsToBounds = true
    newMessageView.layer.cornerRadius = 5
    newMessageView.layer.backgroundColor = backroundColorOfMessage(sentBy: sentBy).cgColor
    
    globalCVVariables.scrollViewHeight = CGFloat(scrollViewHeight) + heightOfLabel + 6 + 10  //Change the size of the scroll view
    //print(newMessageView)
    return newMessageView
}
