//
//  Guess.swift
//  Mastermind
//
//  Created by Lovina on 2/9/20.
//  Copyright © 2020 Lovina. All rights reserved.
//

import Foundation

class Guess: NSObject {
    var guessArray: [String]
    var guessString: String
    var feedback: String
    var guessCount: Int

    init(guessArray: [String]) {
        self.guessArray = guessArray
        self.feedback = ""
        self.guessCount = 0
        var numberString = ""
        for number in guessArray {
            numberString += number
        }
        self.guessString = numberString
    }
}
