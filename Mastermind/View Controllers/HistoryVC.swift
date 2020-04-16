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

    var game: GameManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Current Game's Guess History:"
        view.backgroundColor = .systemYellow
        tableView.backgroundColor = .systemYellow
        tableView.register(UINib(nibName: "GuessHistoryCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.allowsSelection = false
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

extension HistoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let game = game else { return 0 }
        return game.guesses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GuessHistoryCell
        if let guess = game?.guesses[indexPath.row] {
            cell.configure(with: guess)
        }
        return cell
    }
}
