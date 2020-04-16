//
//  MainVC.swift
//  Mastermind
//
//  Created by Lovina on 2/5/20.
//  Copyright © 2020 Lovina. All rights reserved.
//

import UIKit

class MainVC: UIViewController, GameManagerDelegate {

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
    @IBOutlet weak var loadingView: LoadingView!

    let game = GameManager()
    private var textFields: [UITextField] = []
    private var currentTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.mainVCDelegate = self
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
        startGame()
    }

    func prepareForNewGame() {
        if game.numberCombo == [] {
            loadingView.failToLoadLabel.isHidden = false
            loadingView.retryButton.isHidden = false
        } else {
            loadingView.isHidden = true
        }
        resetGameButton.isHidden = true
        submitButton.isHidden = false
        clearPressed()
        guessesLabel.text = "Remaining Guesses: \(game.remainingGuesses)"
        feedbackLabel.text = "Guess the combination from the numbers brelow"
    }

    @objc private func startGame() {
        loadingView.isHidden = false
        game.setNewGameData()
    }

    @objc private func submitPressed() {
        for textfield in textFields {
            guard let number = textfield.text else { return }
            game.currentGuess.append(number)
        }
        game.processGuess()
        if game.win {
            resetGameButton.isHidden = false
            submitButton.isHidden = true
        }
        feedbackLabel.text = game.feedback
        guessesLabel.text = "Remaining Guesses: \(game.remainingGuesses)"
        if game.remainingGuesses == 0 {
            presentGameOver()
        }
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
        } else if currentTextField == textField3 && textField3.text != "" {
            currentTextField?.text = ""
        } else if currentTextField == textField2 && textField2.text != "" {
            currentTextField?.text = ""
        } else {
            currentTextField?.text = ""
            if currentTextField == textField4 && textField4.text == "" { currentTextField = textField3 }
            else if currentTextField == textField3 && textField3.text == "" { currentTextField = textField2 }
            else if currentTextField == textField2 && textField2.text == "" { currentTextField = textField1 }
        }
        highlightCurrentTextField()
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

    private func checkIfSubmitEnabled() {
        if textField1.text == "" || textField2.text == "" || textField3.text == "" || textField4.text == "" {
            disableSubmitButton()
        } else {
            enableSubmitButton()
        }
    }

    private func presentGameOver() {
        var combinationString = ""
        for number in game.numberCombo {
            combinationString += number
        }
        let alert = UIAlertController(title: "GAME OVER", message: "The correct combination was \(combinationString)", preferredStyle: .alert)
        let reviewAction = UIAlertAction(title: "Dismiss", style: .default) { (action) in
            self.revealCode()
        }
        let restartAction = UIAlertAction(title: "Start Another Round", style: .default) { (action) in
            self.startGame()
        }
        alert.addAction(reviewAction)
        alert.addAction(restartAction)
        present(alert, animated: true, completion: nil)
    }

    private func revealCode() {
        feedbackLabel.text = "The correct combination was:"
        textField1.text = game.numberCombo[0]
        textField2.text = game.numberCombo[1]
        textField3.text = game.numberCombo[2]
        textField4.text = game.numberCombo[3]
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
        resetGameButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
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
