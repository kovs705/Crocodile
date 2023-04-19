//
//  GreenButton.swift
//  Crocodile
//
//  Created by Василий Васильевич on 19.04.2023.
//

import UIKit

class GreenButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)

        setTitle(title, for: .normal)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        setTitleColor(.white, for: .normal)
        contentMode = .center
        backgroundColor = UIColor(named: Resources.Colors.greenButtonColor)
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
}
