//
//  TeamCollectionViewCell.swift
//  Crocodile
//
//  Created by mac on 4/20/23.
//

import UIKit
import SnapKit

class TeamCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"
    let imageButtonDelete = UIImage(systemName: "xmark.app")
    let imageButtonEdit = UIImage(systemName: "pencil")
    var onDeleteButton: (() -> Void)?
    
    var teamInfo: Category!
    
    // MARK: - Properties
    
    let nameLabel: UILabel = {
       let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.textAlignment = .center
        lable.textColor = .black
        return lable
    }()
    
    let teamView: UIView = {
       let teamView = UIView()
        teamView.backgroundColor = .white
        teamView.frame = CGRectMake(0, 0, 50, 50)
        teamView.layer.cornerRadius = 40
        return teamView
    }()
    
    let teamEmoji: UILabel = {
        let label = UILabel()
        label.text = "🐊"
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(imageButtonDelete, for: .normal)
        button.tintColor = .red
        return button
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(imageButtonEdit, for: .normal)
        button.tintColor = .green
        return button
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView(team: Team(emoji: emojies.randomElement()!, backColor: backColor.randomElement()!, name: names.randomElement()!, score: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    func configure(with team: Team) {
        print(team.name)
        print(team.backColor)
        print(team.emoji)
        print(team.score)
    }
    
    // MARK: - Private method
    
    private func setupView(team: Team) {
        backgroundColor = .white
        
        contentView.addSubview(teamView)
        teamView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalToSuperview().multipliedBy(0.22)
        }
        
        
        teamView.addSubview(teamEmoji)
        teamEmoji.snp.makeConstraints { make in
            make.centerX.equalTo(teamView)
            make.centerY.equalTo(teamView)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            
        }
        
        contentView.addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(12)
            make.width.height.equalTo(24)
        }
        
        contentView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(8)
            make.width.height.equalTo(24)
        }
        
        
        teamView.backgroundColor = UIColor(named: team.backColor)
        teamEmoji.text = team.emoji
        nameLabel.text = team.name
        
    }
    
}

