//
//  GameManager.swift
//  Mastermind
//
//  Created by Lovina on 4/14/20.
//  Copyright © 2020 Lovina. All rights reserved.
//

import UIKit

protocol GameManagerDelegate: class {
    func prepareForNewGame()
}

class GameManager {

    var numberCombo: [String] = []
    var currentGuess: [String] = []
    var guesses: [Guess] = []
    var remainingGuesses: Int = 10
    var feedback: String = ""
    var win: Bool = false

    weak var mainVCDelegate: GameManagerDelegate?
    weak var historyVCDelegate: GameManagerDelegate?
    private let interactor = Interactor()

    func setNewGameData() {
        fetchCombination()
        win = false
        remainingGuesses = 10
        guesses.removeAll()
    }

    func processGuess() {
        guard currentGuess.count == 4 && numberCombo.count == 4 else { return }
        let guess = Guess(currentGuess)
        compareAndGiveFeedback(for: guess)
        guesses.append(guess)
        guess.guessCount = guesses.count
        resetGuessArray()
        updateRemainingGuessesCount()
    }

    private func compareAndGiveFeedback(for guess: Guess) {
        guard numberCombo.count == 4 && currentGuess.count == 4 else { return }
        if currentGuess[0] == numberCombo[0] && currentGuess[1] == numberCombo[1] && currentGuess[2] == numberCombo[2] && currentGuess[3] == numberCombo[3] {
            guess.feedback = "You win! You have guessed the correct combination!"
            win = true
        } else {
            displayPartiallyCorrectFeedback(for: guess)
        }
        feedback = guess.feedback
    }

    private func displayPartiallyCorrectFeedback(for guess: Guess) {
        var dict = [String: Int]()
        var correctLocationCount: Int = 0
        var incorrectLocationCount: Int = 0
        for digit in numberCombo {
            dict[digit, default: 0] += 1
        }
        for i in 0..<currentGuess.count {
            if currentGuess[i] == numberCombo[i] {
                correctLocationCount += 1
                if let count = dict[currentGuess[i]] {
                    dict[currentGuess[i]] = count - 1
                }
            }
        }
        for i in 0..<currentGuess.count {
            if currentGuess[i] != numberCombo[i] && numberCombo.contains(currentGuess[i]) && dict[currentGuess[i]] ?? 0 > 0 {
                incorrectLocationCount += 1
                if let count = dict[currentGuess[i]] {
                    dict[currentGuess[i]] = count - 1
                }
            }
        }
        if correctLocationCount > 0, incorrectLocationCount > 0 {
            guess.feedback = "You have \(correctLocationCount) number(s) in the correct location and \(incorrectLocationCount) number(s) in a incorrect location."
        } else if correctLocationCount > 0, incorrectLocationCount == 0 {
            guess.feedback = "You have \(correctLocationCount) number(s) in the correct location."
        } else if correctLocationCount == 0, incorrectLocationCount > 0 {
            guess.feedback = "You have \(incorrectLocationCount) number(s) in an incorrect location."
        } else {
            guess.feedback = "Your guess is incorrect. Try different numbers."
        }
    }

    private func fetchCombination() {
        interactor.fetchNumbers { (response) in
            if let response = response {
                self.numberCombo = response
                print(self.numberCombo)
                self.mainVCDelegate?.prepareForNewGame()
                self.historyVCDelegate?.prepareForNewGame()
            }
        }
    }

    private func updateRemainingGuessesCount() {
        remainingGuesses -= 1
        guard remainingGuesses >= 0 else { return }
    }

    private func resetGuessArray() {
        currentGuess = []
    }
}
