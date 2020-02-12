//
//  GuessHistoryCell.swift
//  Mastermind
//
//  Created by Lovina on 2/9/20.
//  Copyright © 2020 Lovina. All rights reserved.
//

import UIKit

class GuessHistoryCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .systemYellow
        feedbackLabel.numberOfLines = 0
    }

    func configure(with guess: Guess) {
        countLabel.text = "Guess #\(guess.guessCount):"
        numberLabel.text = guess.guessString
        feedbackLabel.text = guess.feedback
    }
}
