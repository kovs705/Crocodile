//
//  GreenButton.swift
//  Crocodile
//
//  Created by Василий Васильевич on 19.04.2023.
//

import UIKit

class GreenButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: String, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = UIColor(named: backgroundColor)
        self.setTitle(title, for: .normal)
    }

    private func setupButton() {
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        setTitleColor(.white, for: .normal)

        contentMode = .center
        layer.cornerRadius = 10
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
