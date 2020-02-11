//
//  MainVCTest.swift
//  MastermindTests
//
//  Created by Lovina on 2/10/20.
//  Copyright © 2020 Lovina. All rights reserved.
//

import XCTest
@testable import Mastermind

class MainVCTest: XCTestCase {

    var mainVC: MainVC!

    override func setUp() {
        mainVC = MainVC(nibName: "MainVC", bundle: nil)
        mainVC.loadView()
    }

    override func tearDown() {
        mainVC = nil
    }

    func testCorrectGuessFeedback() {
        mainVC.numberCombo = ["1", "2", "3", "4"]
        mainVC.guessArray = ["1", "2", "3", "4"]
        let guess = Guess(guessArray: mainVC.guessArray)
        mainVC.compareAndGiveFeedback(for: guess)
        XCTAssertEqual(mainVC.feedbackLabel.text, Feedback.correct.rawValue)
    }

    func testCorrectLocationFeedback() {
        mainVC.numberCombo = ["1", "2", "3", "4"]
        mainVC.guessArray = ["1", "0", "0", "0"]
        let guess = Guess(guessArray: mainVC.guessArray)
        mainVC.compareAndGiveFeedback(for: guess)
        XCTAssertEqual(mainVC.feedbackLabel.text, Feedback.correctLocation.rawValue)
    }

    func testCorrectLocationFeedback2() {
        mainVC.numberCombo = ["1", "2", "3", "4"]
        mainVC.guessArray = ["0", "1", "0", "4"]
        let guess = Guess(guessArray: mainVC.guessArray)
        mainVC.compareAndGiveFeedback(for: guess)
        XCTAssertEqual(mainVC.feedbackLabel.text, Feedback.correctLocation.rawValue)
    }

    func testCorrectNumberFeedback() {
        mainVC.numberCombo = ["1", "2", "3", "4"]
        mainVC.guessArray = ["4", "0", "0", "0"]
        let guess = Guess(guessArray: mainVC.guessArray)
        mainVC.compareAndGiveFeedback(for: guess)
        XCTAssertEqual(mainVC.feedbackLabel.text, Feedback.correctNumber.rawValue)
    }

    func testIncorrectFeedback() {
        mainVC.numberCombo = ["1", "2", "3", "4"]
        mainVC.guessArray = ["0", "0", "0", "0"]
        let guess = Guess(guessArray: mainVC.guessArray)
        mainVC.compareAndGiveFeedback(for: guess)
        XCTAssertEqual(mainVC.feedbackLabel.text, Feedback.incorrect.rawValue)
    }
}
