//
//  File.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 17-12-28.
//  Copyright © 2017-2019 Alexandre Gaubil. All rights reserved.
//

import Foundation

///Func to remove all symbols and replace them by spaces
func clearTextOfSymbols(text: String) -> String {

    var text = text

    text = text.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range:nil)
    text = text.replacingOccurrences(of: ";", with: " ", options: NSString.CompareOptions.literal, range:nil)
    text = text.replacingOccurrences(of: "\'", with: " ", options: NSString.CompareOptions.literal, range:nil)
    text = text.replacingOccurrences(of: "\"", with: " ", options: NSString.CompareOptions.literal, range:nil)
    text = text.replacingOccurrences(of: "(", with: " ", options: NSString.CompareOptions.literal, range:nil)
    text = text.replacingOccurrences(of: ")", with: " ", options: NSString.CompareOptions.literal, range:nil)
    text = text.replacingOccurrences(of: "#", with: " ", options: NSString.CompareOptions.literal, range:nil)
    text = text.replacingOccurrences(of: "!!", with: "!", options: NSString.CompareOptions.literal, range: nil)
    text = text.replacingOccurrences(of: "??", with: "?", options: NSString.CompareOptions.literal, range: nil)
    text = text.replacingOccurrences(of: "!", with: ".", options: NSString.CompareOptions.literal, range:nil)

    text = text.replacingOccurrences(of: " ?", with: "?", options: NSString.CompareOptions.literal, range:nil)
    text = text.replacingOccurrences(of: "? ", with: "?", options: NSString.CompareOptions.literal, range:nil)
    text = text.replacingOccurrences(of: "?", with: " ? ", options: NSString.CompareOptions.literal, range:nil)

    return text
}
