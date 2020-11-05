//
//  Extension 2.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-02-24.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
}
