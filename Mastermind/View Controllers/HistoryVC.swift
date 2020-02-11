//
//  HistoryVC.swift
//  Mastermind
//
//  Created by Lovina on 2/9/20.
//  Copyright © 2020 Lovina. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!

    private var guesses: [Guess] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        tableView.backgroundColor = .systemYellow
        label.text = "Current Game's Guess History:"
        tableView.dataSource = self
        tableView.register(UINib(nibName: "GuessHistoryCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.allowsSelection = false
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

extension HistoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guesses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GuessHistoryCell
        let guess = guesses[indexPath.row]
        cell.configure(with: guess)
        return cell
    }
}

extension HistoryVC: MainVCDelegate {
    func mainVCDidSubmitGuess(_ mainVC: MainVC, guess: Guess) {
        guesses.append(guess)
        guess.guessCount = guesses.count
    }

    func mainVCDidRestartGame(_ mainVC: MainVC) {
        guesses.removeAll()
    }
}
