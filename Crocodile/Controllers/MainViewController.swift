//
//  ViewController.swift
//  Crocodile
//
//  Created by Kovs on 17.04.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    let backgroundImage = UIImageView(image: UIImage(named: Resources.Image.backgroundImage))
    let crocodileImage = UIImageView(image: UIImage(named: Resources.Image.crocodileImage))
    let startGameButton = GreenButton(title: "Старт игры")
    let rulesButton = GreenButton(title: "Правила игры")
    let grassImage1 = UIImageView(image: UIImage(named: Resources.Image.grassImage))
    let grassImage2 = UIImageView(image: UIImage(named: Resources.Image.grassImage))

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundImage()
        setupCrocodileImage()
        setupStartGameButton()
        setupRulesGameButton()
        setupGrassImage()

        
    }

    func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }

    func setupCrocodileImage() {
        view.addSubview(crocodileImage)
        crocodileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(172)
            make.left.equalToSuperview().offset(54)
            make.right.equalToSuperview().offset(-54)
        }
    }

    func setupStartGameButton() {
        view.addSubview(startGameButton)
        startGameButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(crocodileImage.snp.bottom).offset(48)
            make.width.equalTo(274)
            make.height.equalTo(83)
        }
    }

    func setupRulesGameButton() {
        view.addSubview(rulesButton)
        rulesButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(startGameButton.snp.bottom).offset(48)
            make.width.equalTo(211)
            make.height.equalTo(63)
        }
    }

    func setupGrassImage() {
        view.addSubview(grassImage1)
        grassImage1.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(95)
            make.height.equalTo(70)
        }

        view.addSubview(grassImage2)
        grassImage2.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(95)
            make.height.equalTo(70)
        }
    }
}
