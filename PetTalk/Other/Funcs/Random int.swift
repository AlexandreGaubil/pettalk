//
//  Random int.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 17-12-16.
//  Copyright © 2017-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

func randomIntFrom(start: Int, to end: Int) -> Int {
    var a = start
    var b = end
    // swap to prevent negative integer crashes
    if a > b {
        swap(&a, &b)
    }
    return Int(arc4random_uniform(UInt32(b - a + 1))) + a
}
