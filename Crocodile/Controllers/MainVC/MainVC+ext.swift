//
//  MainVC+ext.swift
//  Crocodile
//
//  Created by Kovs on 20.04.2023.
//

import UIKit
import SnapKit

class MainVC: UIViewController {
    
    let stackView = UIStackView()
    
    let backgroundImage = UIImageView(image: UIImage(named: Resources.Image.backgroundImage))
    let crocodileImage = UIImageView(image: UIImage(named: Resources.Image.crocodileImage))
    
    let startGameButton = GreenButton(backgroundColor: Resources.Colors.greenButtonColor, title: "Старт игры")
    let rulesButton = GreenButton(backgroundColor: Resources.Colors.greenButtonColor, title: "Правила игры")
    let resultsButton = GreenButton(backgroundColor: Resources.Colors.orangeButtonColor, title: "Результаты")
    
    let grassImage1 = UIImageView(image: UIImage(named: Resources.Image.grassImage))
    let grassImage2 = UIImageView(image: UIImage(named: Resources.Image.grassImage))
    
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
            make.top.equalToSuperview().offset(130)
            make.left.equalToSuperview().offset(54)
            make.right.equalToSuperview().offset(-54)
        }
    }
    
    
    func setupStackView() {
        view.addSubview(stackView)
        
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.alignment = .center
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(crocodileImage.snp.bottom).offset(48)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        stackView.addArrangedSubview(startGameButton)
        stackView.addArrangedSubview(rulesButton)
        stackView.addArrangedSubview(resultsButton)
    }

    func setupStartGameButton() {
//        view.addSubview(startGameButton)
        startGameButton.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(crocodileImage.snp.bottom).offset(48)
            make.width.equalTo(274)
            make.height.equalTo(83)
        }
        
        startGameButton.addTarget(self, action: #selector(startPressed), for: .touchUpInside)
    }
    
    @objc func startPressed() {
        let teamVC = TeamViewController()
        navigationController?.pushViewController(teamVC, animated: true)
    }

    func setupRulesGameButton() {
//        view.addSubview(rulesButton)
        rulesButton.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(startGameButton.snp.bottom).offset(48)
            make.width.equalTo(211)
            make.height.equalTo(65)
        }
        
        rulesButton.addTarget(self, action: #selector(openRules), for: .touchUpInside)
    }
    
    @objc func openRules() {
        let rulesPage = RulesViewController()
        navigationController?.pushViewController(rulesPage, animated: true)
    }
    
    func setupResultsButton() {
        resultsButton.snp.makeConstraints { make in
            make.width.equalTo(211)
            make.height.equalTo(65)
        }
    }
    

    func setupGrassImage() {
        view.addSubview(grassImage1)
        grassImage1.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(95)
            make.height.equalTo(70)
        }

        view.addSubview(grassImage2)
        grassImage2.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(95)
            make.height.equalTo(70)
        }
    }
}
