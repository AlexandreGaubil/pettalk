//
//  Image.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 2018-03-03.
//  Copyright © 2018 Alexandre Gaubil. All rights reserved.
//

import UIKit
import os.log

///Func to display an image or a GIF
func displayImage(imageNumber: Int, scrollViewHeight: Int, scrollViewWidth: Int) -> UIView {
    let defaults = UserDefaults.standard
    let imagesURLArray : [String] = defaults.array(forKey: "imagesArray") as! [String]
    let imageTypeArray : [String] = defaults.array(forKey: "imagesTypeArray") as! [String]
    //COORDINATES
    let xCoordinateMessage = returnxCoordinateOfMessage(sentBy: "p")
    let width = widthOfImage(scrollViewWidth: CGFloat(scrollViewWidth))
    let newMessageView = UIView(frame: CGRect(x: CGFloat(xCoordinateMessage), y: CGFloat(scrollViewHeight + 10), width: width, height: width))
    
    if imageTypeArray[imageNumber] == "img" { //IMAGE
        
        var image = UIImage(imageLiteralResourceName: imagesURLArray[imageNumber])
        let size : CGSize = CGSize(width: width, height: width)
        image = image.scaled(to: size, scalingMode: .aspectFit)
        let imageview = UIImageView(image: image)
        newMessageView.addSubview(imageview)
        imageview.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        newMessageView.frame = CGRect(x: CGFloat(xCoordinateMessage), y: CGFloat(scrollViewHeight + 10), width: image.size.width, height: image.size.height)
        //Change the size of the scroll view
        globalCVVariables.scrollViewHeight = CGFloat(scrollViewHeight) + image.size.height + 16
        
    }
    newMessageView.clipsToBounds = true
    newMessageView.layer.cornerRadius = 5
    if imageTypeArray[imageNumber] == "img" {
        newMessageView.layer.backgroundColor = backroundColorOfMessage(sentBy: "p").cgColor
    }
    
    return newMessageView
}
