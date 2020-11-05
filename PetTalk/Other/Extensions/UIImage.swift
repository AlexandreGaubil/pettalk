//
//  UIImage.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 2018-05-26.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

// MARK: - Image Scaling.
extension UIImage {
    
    /// Represents a scaling mode
    enum ScalingMode {
        case aspectFill
        case aspectFit
        
        /// Calculates the aspect ratio between two sizes
        ///
        /// - parameters:
        ///     - size:      the first size used to calculate the ratio
        ///     - otherSize: the second size used to calculate the ratio
        ///
        /// - return: the aspect ratio between the two sizes
        func aspectRatio(between size: CGSize, and otherSize: CGSize) -> (CGFloat, CGFloat) {
            let aspectWidth  = size.width/otherSize.width
            let aspectHeight = size.height/otherSize.height
            
            switch self {
            case .aspectFill:
                //return max(aspectWidth, aspectHeight)
                return (aspectWidth, aspectHeight)
            case .aspectFit:
                //return min(aspectWidth, aspectHeight)
                return (aspectWidth, aspectHeight)
            }
        }
    }
    
    /// Scales an image to fit within a bounds with a size governed by the passed size. Also keeps the aspect ratio.
    ///
    /// - parameter:
    ///     - newSize:     the size of the bounds the image must fit within.
    ///     - scalingMode: the desired scaling mode
    ///
    /// - returns: a new scaled image.
    func scaled(to newSize: CGSize, scalingMode: UIImage.ScalingMode = .aspectFill) -> UIImage {
        
        let aspectRatio = scalingMode.aspectRatio(between: newSize, and: size)
        
        //Build the rectangle representing the area to be drawn
        var scaledImageRect = CGRect.zero
        
        /*if scalingMode == .aspectFill {
         ratio = max(aspectRatio.0, aspectRatio.1)
         } else {
         ratio = min(aspectRatio.0, aspectRatio.1)
         }*/
        
        scaledImageRect.size.width  = size.width * aspectRatio.0
        scaledImageRect.size.height = size.height * aspectRatio.0
        //scaledImageRect.origin.x    = (newSize.width - size.width * ratio) / 2.0
        //scaledImageRect.origin.y    = (newSize.height - size.height * ratio) / 2.0
        scaledImageRect.origin.x    = 0
        scaledImageRect.origin.y = 0
        let newSize2 = CGSize(width: scaledImageRect.size.width, height: scaledImageRect.size.height)
        //newSize.width = scaledImageRect.size.width
        //newSize.height = scaledImageRect.size.height
        /* Draw and retrieve the scaled image */
        UIGraphicsBeginImageContextWithOptions(newSize2, false, 0.0)
        
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
}
