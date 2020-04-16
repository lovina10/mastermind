//
//  GameManagerTest.swift
//  MastermindTests
//
//  Created by Lovina on 4/15/20.
//  Copyright © 2020 Lovina. All rights reserved.
//

import XCTest
@testable import Mastermind

class GameManagerTest: XCTestCase {

    var game: GameManager!

    override func setUp() {
        game = GameManager()
    }

    override func tearDown() {
        game = nil
    }

    func testCorrectGuessFeedback() {
        game.numberCombo = ["1", "2", "3", "4"]
        game.currentGuess = ["1", "2", "3", "4"]
        game.processGuess()
        XCTAssertEqual(game.feedback, "You win! You have guessed the correct combination!")
    }

    func testCorrectLocationFeedback() {
        game.numberCombo = ["1", "2", "3", "4"]
        game.currentGuess = ["1", "0", "0", "0"]
        game.processGuess()
        XCTAssertEqual(game.feedback, "You have 1 number(s) in the correct location.")
    }

    func testOneCorrectAndTwoIncorrectLocation() {
        game.numberCombo = ["1", "2", "3", "4"]
        game.currentGuess = ["3", "1", "1", "4"]
        game.processGuess()
        XCTAssertEqual(game.feedback, "You have 1 number(s) in the correct location and 2 number(s) in an incorrect location.")
    }

    func testTwoCorrectAndTwoIncorrectLocation() {
        game.numberCombo = ["1", "2", "3", "4"]
        game.currentGuess = ["2", "1", "3", "4"]
        game.processGuess()
        XCTAssertEqual(game.feedback, "You have 2 number(s) in the correct location and 2 number(s) in an incorrect location.")
    }

    func testCorrectNumberFeedback() {
        game.numberCombo = ["1", "2", "3", "4"]
        game.currentGuess = ["4", "0", "0", "0"]
        game.processGuess()
        XCTAssertEqual(game.feedback, "You have 1 number(s) in an incorrect location.")
    }

    func testTwoIncorrectLocation() {
        game.numberCombo = ["1", "2", "3", "4"]
        game.currentGuess = ["4", "0", "1", "1"]
        game.processGuess()
        XCTAssertEqual(game.feedback, "You have 2 number(s) in an incorrect location.")
    }

    func testIncorrectFeedback() {
        game.numberCombo = ["1", "2", "3", "4"]
        game.currentGuess = ["0", "0", "0", "0"]
        game.processGuess()
        XCTAssertEqual(game.feedback, "Your guess is incorrect. Try different numbers.")
    }

}
