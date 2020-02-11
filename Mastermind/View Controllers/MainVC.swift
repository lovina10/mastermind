//
//  MainVC.swift
//  Mastermind
//
//  Created by Lovina on 2/5/20.
//  Copyright © 2020 Lovina. All rights reserved.
//

import UIKit
import Alamofire

enum Feedback: String {
    case incorrect = "Your guess is incorrect. Try different numbers."
    case correctNumber = "You guessed at least one correct number."
    case correctLocation = "You guessed at least one correct number in a correct location."
    case correct = "You win! You have guessed the correct combination!"
}

protocol MainVCDelegate: class {
    func mainVCDidSubmitGuess(_ mainVC: MainVC, guess: Guess)
    func mainVCDidRestartGame(_ mainVC: MainVC)
}

class MainVC: UIViewController {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var guessesLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var backspaceButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var resetGameButton: UIButton!

    weak var delegate: MainVCDelegate?
    
    let interactor = Interactor()
    var textFields: [UITextField] = []
    var currentTextField: UITextField?
    var numberCombo: [String] = []
    var guessArray: [String] = []
    var remainingGuesses: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        setUpButtons()
        textFields = [textField1, textField2, textField3, textField4]
        for textField in textFields {
            textField.borderStyle = .none
            textField.backgroundColor = .systemTeal
            textField.layer.cornerRadius = 9
            textField.clipsToBounds = true
            textField.delegate = self
        }
        setUpNewGame()
    }

    func compareAndGiveFeedback(for guess: Guess) {
        guard numberCombo.count == 4 && guess.guessArray.count == 4 else { return }
        let guessArray = guess.guessArray
        if guessArray[0] == numberCombo[0] && guessArray[1] == numberCombo[1] && guessArray[2] == numberCombo[2] && guessArray[3] == numberCombo[3] {
            guess.feedback = Feedback.correct.rawValue
            resetGameButton.isHidden = false
            submitButton.isHidden = true
        } else if guessArray[0] == numberCombo[0] || guessArray[1] == numberCombo[1] || guessArray[2] == numberCombo[2] || guessArray[3] == numberCombo[3] {
            guess.feedback = Feedback.correctLocation.rawValue
        } else {
            for number in guessArray {
                if numberCombo.contains(number) {
                    guess.feedback = Feedback.correctNumber.rawValue
                    return
                }
            }
            guess.feedback = Feedback.incorrect.rawValue
        }
    }

    @objc private func setUpNewGame() {
        interactor.fetchNumbers { (response) in
            guard let response = response else { return }
            self.numberCombo = response
            print(self.numberCombo)
        }
        resetGameButton.isHidden = true
        submitButton.isHidden = false
        clearPressed()
        remainingGuesses = 10
        guessesLabel.text = "Remaining Guesses: \(remainingGuesses)"
        feedbackLabel.text = "Guess the combination from the numbers below"
        delegate?.mainVCDidRestartGame(self)
    }

    @objc private func submitPressed() {
        for textfield in textFields {
            guard let number = textfield.text else { return }
            guessArray.append(number)
        }
        guard guessArray.count == 4 && numberCombo.count == 4 else { return }
        let guess = Guess(guessArray: guessArray)
        compareAndGiveFeedback(for: guess)
        feedbackLabel.text = guess.feedback
        delegate?.mainVCDidSubmitGuess(self, guess: guess)
        updateRemainingGuessesCount()
        if remainingGuesses == 0 {
            presentGameOver()
        }
        guessArray = []
        animateLabels()
    }

    @objc private func numberPressed(_ sender: UIButton) {
        currentTextField?.text = String(sender.tag)
        if currentTextField == textField1 && textField2.text == "" { currentTextField = textField2 }
        else if currentTextField == textField2 && textField3.text == "" { currentTextField = textField3 }
        else if currentTextField == textField3 && textField4.text == "" { currentTextField = textField4 }
        else if currentTextField == textField4 { currentTextField = nil }
        highlightCurrentTextField()
        checkIfSubmitEnabled()
    }

    @objc private func backspacePressed() {
        if currentTextField == nil {
            currentTextField = textField4
            currentTextField?.text = ""
            highlightCurrentTextField()
        } else if currentTextField == textField3 && textField3.text != "" {
            currentTextField?.text = ""
            highlightCurrentTextField()
        } else if currentTextField == textField2 && textField2.text != "" {
            currentTextField?.text = ""
            highlightCurrentTextField()
        } else {
            currentTextField?.text = ""
            if currentTextField == textField4 && textField4.text == "" { currentTextField = textField3 }
            else if currentTextField == textField3 && textField3.text == "" { currentTextField = textField2 }
            else if currentTextField == textField2 && textField2.text == "" { currentTextField = textField1 }
            highlightCurrentTextField()
        }
        checkIfSubmitEnabled()
    }

    @objc private func clearPressed() {
        textField1.text = ""
        textField2.text = ""
        textField3.text = ""
        textField4.text = ""
        currentTextField = textField1
        highlightCurrentTextField()
        disableSubmitButton()
    }

    private func updateRemainingGuessesCount() {
        remainingGuesses -= 1
        guard remainingGuesses >= 0 else { return }
        guessesLabel.text = "Remaining Guesses: \(remainingGuesses)"
    }

    private func checkIfSubmitEnabled() {
        if textField1.text == "" || textField2.text == "" || textField3.text == "" || textField4.text == "" {
            disableSubmitButton()
        } else {
            enableSubmitButton()
        }
    }

    private func presentGameOver() {
        var combinationString = ""
        for number in numberCombo {
            combinationString += number
        }
        let alert = UIAlertController(title: "GAME OVER", message: "The correct combination was \(combinationString)", preferredStyle: .alert)
        let reviewAction = UIAlertAction(title: "Dismiss", style: .default) { (action) in
            self.revealCode()
        }
        let restartAction = UIAlertAction(title: "Start Another Round", style: .default) { (action) in
            self.setUpNewGame()
        }
        alert.addAction(reviewAction)
        alert.addAction(restartAction)
        present(alert, animated: true, completion: nil)
    }

    private func revealCode() {
        feedbackLabel.text = "The correct combination was:"
        textField1.text = numberCombo[0]
        textField2.text = numberCombo[1]
        textField3.text = numberCombo[2]
        textField4.text = numberCombo[3]
        submitButton.isHidden = true
        resetGameButton.isHidden = false
    }

    private func highlightCurrentTextField() {
        currentTextField?.backgroundColor = .yellow
        for textField in textFields {
            if textField != currentTextField {
                textField.backgroundColor = .systemTeal
            }
        }
    }

    private func enableSubmitButton() {
        submitButton.isEnabled = true
        submitButton.backgroundColor = .systemGreen
    }

    private func disableSubmitButton() {
        submitButton.isEnabled = false
        submitButton.backgroundColor = .systemGray2
    }

    private func setUpButtons() {
        zeroButton.tag = 0
        oneButton.tag = 1
        twoButton.tag = 2
        threeButton.tag = 3
        fourButton.tag = 4
        fiveButton.tag = 5
        sixButton.tag = 6
        sevenButton.tag = 7

        let numberButtons = [zeroButton, oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton]
        for button in numberButtons {
            button?.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }
        backspaceButton.addTarget(self, action: #selector(backspacePressed), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearPressed), for: .touchUpInside)
        resetGameButton.addTarget(self, action: #selector(setUpNewGame), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)

        clearButton.layer.cornerRadius = 8
        clearButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        submitButton.layer.cornerRadius = 10
        resetGameButton.layer.cornerRadius = 10
    }

    private func animateLabels() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.guessesLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.feedbackLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil)
        UIView.animate(withDuration: 0.25) {
            self.guessesLabel.transform = CGAffineTransform.identity
            self.feedbackLabel.transform = CGAffineTransform.identity
        }
    }
}

extension MainVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        currentTextField = textField
        highlightCurrentTextField()
        return false
    }
}
