//
//  ResultCell.swift
//  Crocodile
//
//  Created by Kovs on 23.04.2023.
//

import UIKit
import SnapKit

class ResultCell: UIView {
    
    var team: Team!
    
    var teamName: String!
    var teamImage: String!
    var teamScore: Int!
    var teamEmoji: String!
    
    // MARK: - Properties
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let teamView: UIView = {
       let teamView = UIView()
        teamView.backgroundColor = .white
        teamView.frame = CGRectMake(0, 0, 50, 50)
        teamView.layer.cornerRadius = 40
        return teamView
    }()
    
    let teamEmojiLabel: UILabel = {
        let label = UILabel()
        label.text = "🐊"
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    let teamScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(team: Team) {
        super.init(frame: .zero)
        self.teamName = team.name
        self.teamView.backgroundColor = UIColor(named: team.backColor)
        self.teamScore = team.score
        self.teamEmoji = team.emoji
        
        
        // configure(with: team)
        setupView(team: team)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with team: Team) {
        print(team.name)
        print(team.backColor)
        print(team.emoji)
        print(team.score)
    }
    
    // MARK: - Private method
    
    private func setupView(team: Team) {
        backgroundColor = .white
        
        self.addSubview(teamView)
        teamView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalToSuperview().multipliedBy(0.22)
        }
        
        
        teamView.addSubview(teamEmojiLabel)
        teamEmojiLabel.snp.makeConstraints { make in
            make.centerX.equalTo(teamView)
            make.centerY.equalTo(teamView)
        }
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            
        }
        
        self.addSubview(teamScoreLabel)
        teamScoreLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(self.snp.trailing).offset(-30)
        }
        
        teamView.backgroundColor = UIColor(named: team.backColor)
        teamEmojiLabel.text = team.emoji
        nameLabel.text = team.name
        teamScoreLabel.text = String(team.score)
        
    }
    
}

