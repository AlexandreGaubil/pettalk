//
//  Theme analysis.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 2019-03-26.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import Foundation

func themeAnalysis(text: String) -> String? {
  var themesOfText: [String: Int] = [:]

  for word in text.components(separatedBy: " ") {
    let themes = ThemesWords[word]
  if themes != nil {
      for theme in themes {
        if !(themesOfText.contains(theme)) {
          themesOfText[theme] = 1
        } else {
          themesOfText[theme] += 1
        }
      }
    }
  }

var mainTheme = nil
var numberOfRepetitions = 0
for theme in themes {
  if themes[theme.value] > numberOfRepetitions {
    mainTheme = theme.key
    numberOfRepetitions = theme.value
  }
}

  return mainTheme
}