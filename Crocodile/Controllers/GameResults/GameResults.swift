//
//  GameResults.swift
//  Crocodile
//
//  Created by Kovs on 23.04.2023.
//

import UIKit
import SnapKit

class GameResults: UIViewController {
    
    let backgroundImage = UIImageView(image: UIImage(named: Resources.Image.backgroundImage))
    var teams: [Team] = []
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("На главную", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5230828524, green: 0.7005900741, blue: 0.2440984249, alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonPressed() {
        let mainVC = MainViewController()
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    func getTeams() {
        TeamManager.shared.getTeams { [weak self ] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let teams):
                
                self.teams = teams
                print(self.teams)
                
                
            case .failure(let failure):
                fatalError(failure.rawValue)
            }
        }
    }
    
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = false
        scrollView.bounces = true
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.bounces = true
        scrollView.backgroundColor = .clear
        
        return scrollView
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.backgroundColor = .clear
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    func placeSV() {
        self.backgroundImage.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(backgroundImage)
            make.top.equalTo(backgroundImage).offset(90)
        }
    }
    
    func placeStackView() {
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.top.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(225)
        }
        
        for team in teams {
            stackView.addArrangedSubview(ResultCell(team: team))
        }
    }
    
    func setupBackgroundImage() {
        self.view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    
}
