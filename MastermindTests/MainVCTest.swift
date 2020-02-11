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
        mainVC.compareAndGiveFeedback()
        XCTAssertEqual(mainVC.feedbackLabel.text, "You win! You have guessed the correct number combination!")
    }

    func testCorrectLocationFeedback() {
        mainVC.numberCombo = ["1", "2", "3", "4"]
        mainVC.guessArray = ["1", "0", "0", "0"]
        mainVC.compareAndGiveFeedback()
        XCTAssertEqual(mainVC.feedbackLabel.text, "You guessed a correct number in a correct location.")
    }

    func testCorrectNumberFeedback() {
        mainVC.numberCombo = ["1", "2", "3", "4"]
        mainVC.guessArray = ["4", "0", "0", "0"]
        mainVC.compareAndGiveFeedback()
        XCTAssertEqual(mainVC.feedbackLabel.text, "You guessed at least one correct number.")
    }

    func testIncorrectFeedback() {
        mainVC.numberCombo = ["1", "2", "3", "4"]
        mainVC.guessArray = ["0", "0", "0", "0"]
        mainVC.compareAndGiveFeedback()
        XCTAssertEqual(mainVC.feedbackLabel.text, "Your guess is incorrect.")
    }
}
