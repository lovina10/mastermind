//
//  LoadingView.swift
//  Mastermind
//
//  Created by Lovina on 2/11/20.
//  Copyright © 2020 Lovina. All rights reserved.
//

import UIKit

class LoadingView: UIView {

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
    }
}
