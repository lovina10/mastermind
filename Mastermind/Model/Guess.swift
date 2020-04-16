//
//  Guess.swift
//  Mastermind
//
//  Created by Lovina on 2/9/20.
//  Copyright © 2020 Lovina. All rights reserved.
//

import Foundation

class Guess: NSObject {
    var guessString: String
    var feedback: String = ""
    var guessCount: Int = 0

    init(_ guessArray: [String]) {
        var numberString = ""
        for number in guessArray {
            numberString += number
        }
        guessString = numberString
    }
}
