//
//  display_new_message.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 17-12-19.
//  Copyright © 2017 Alexandre Gaubil. All rights reserved.
//

import UIKit

///XCOORDINATE OF MESSAGE
func returnxCoordinateOfMessage(sentBy: String) -> Int {
    var xCoordinateMessage = 50
    
    //Change the width of the label depending on the type of device it is
    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
        //iPad
        switch sentBy {
        case "u":
            if UIDefaults.screenWidth > 800 {
                xCoordinateMessage = 150
            } else {
                xCoordinateMessage = 30
            }
        default:
            xCoordinateMessage = 30
        }
    default:
        //iPhone, iPod, unspecified and other
        switch sentBy {
        case "u":
            xCoordinateMessage = 50
        default:
            xCoordinateMessage = 20
        }
    }
    
    return xCoordinateMessage
}

///TEXT COLOR
func textColorOfMessage(sentBy: String) -> UIColor {
    var textColor = UIColor.black
    if sentBy == "u" {
        textColor = .white
    }
    return textColor
}

///BACKROUND COLOR
func backroundColorOfMessage(sentBy: String) -> UIColor {
    let defaults = UserDefaults.standard
    var backroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
    if sentBy == "u" {
        if defaults.string(forKey: "color") == "blue" {
            backroundColor = UIDefaults.colorUserBoy
        } else {
            backroundColor = UIDefaults.colorUserGirl
        }
    }
    return backroundColor
}

///WIDTH OF LABEL
func widthOfLabelFunc(sentBy: String, scrollViewWidth: CGFloat, xCoordinate: Int) -> CGFloat{
    
    ///Variable to store width of label
    var widthOfLabel = scrollViewWidth
    
    //Change the width of the label depending on the type of device it is
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
        // It's an iPhone or an iPod
        widthOfLabel = CGFloat(Int(scrollViewWidth) - (returnxCoordinateOfMessage(sentBy: "u") + 20))
    case .pad:
        // It's an iPad
        widthOfLabel = CGFloat(Int(scrollViewWidth) - (returnxCoordinateOfMessage(sentBy: "u") + 40))
    default:
        widthOfLabel = CGFloat(Int(UIDefaults.screenWidth) - (returnxCoordinateOfMessage(sentBy: "u") + 20))
    }
    
    return widthOfLabel
}

func widthOfImage(scrollViewWidth: CGFloat) -> CGFloat {
    ///Variable to store width of label
    var widthOfLabel = scrollViewWidth
    
    //Change the width of the label depending on the type of device it is
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
        // It's an iPhone or an iPod
        widthOfLabel = CGFloat(Int(scrollViewWidth) - (returnxCoordinateOfMessage(sentBy: "u") + 100))
    case .pad:
        // It's an iPad
        //widthOfLabel = CGFloat(Int(scrollViewWidth) - (returnxCoordinateOfMessage(sentBy: "u") + 200))
        widthOfLabel = 400
    default:
        widthOfLabel = CGFloat(Int(UIDefaults.screenWidth) - (returnxCoordinateOfMessage(sentBy: "u") + 100))
    }
    
    return widthOfLabel
}

func fontSize() -> Int {
    var fontSize = 17
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
        // It's an iPhone or an iPod
        fontSize = Int(UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).pointSize)
    case .pad:
        // It's an iPad
        fontSize = UIDefaults.fontSizeForiPad
    default:
        fontSize = UIDefaults.fontSizeForiPad
    }
    return fontSize
}
