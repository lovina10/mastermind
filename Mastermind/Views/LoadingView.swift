//
//  LoadingView.swift
//  Mastermind
//
//  Created by Lovina on 2/11/20.
//  Copyright © 2020 Lovina. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    @IBOutlet weak var failToLoadLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!

    let interactor = Interactor()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        let nib = UINib(nibName: "LoadingView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        failToLoadLabel.text = "Game is down right now. Please try again later."
        retryButton.addTarget(self, action: #selector(retryButtonPressed), for: .touchUpInside)
        failToLoadLabel.isHidden = true
        retryButton.isHidden = true
    }

    @objc private func retryButtonPressed() {
        interactor.fetchNumbers { (response) in
            guard response != nil else { return }
            self.isHidden = true
        }
    }
}
