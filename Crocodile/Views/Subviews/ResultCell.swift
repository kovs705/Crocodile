//
//  ResultCell.swift
//  Crocodile
//
//  Created by Kovs on 23.04.2023.
//

import UIKit


class ResultCell: UIView {
    
    let teamInformationImage = UIImageView(image: UIImage(named: Resources.Image.teamInformationImage))
    var pictureTeamImage = UIImageView(image: UIImage(named: Resources.Image.cowboyImage))
    let teamNameLabel = UILabel()
    
    var currentScoresLabel = UILabel()
    let currentScoresNameLabel = UILabel() // Очки
    let oneScoreLabel = UILabel()
    
    var teamName: String!
    var teamImage: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    init(teamName: String, teamImage: String) {
        super.init(frame: .zero)
        self.teamName = teamName
        self.teamImage = teamImage
        
        initializeSELF()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeSELF() {
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 150)
        self.backgroundColor = .white
        
        setupTeamNameLabel()
        setupPictureTeamImage()
        setupCurrentScoresLabel()
        setupCurrentScoresNameLabel()
    }
    
    // имя команды
    func setupTeamNameLabel() {
        self.addSubview(teamNameLabel)
        teamNameLabel.text = "Ковбои"
        teamNameLabel.textColor = .black
        teamNameLabel.font = UIFont.systemFont(ofSize: 20)
        teamNameLabel.contentMode = .center
        teamNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(34)
            make.centerY.equalTo(self)
        }
    }
    
    // картинка комманды
    func setupPictureTeamImage() {
        self.addSubview(pictureTeamImage)
        pictureTeamImage.snp.makeConstraints { make in
            make.width.equalTo(56)
            make.height.equalTo(56)
            make.leading.equalTo(self.snp.leading).offset(27)
            make.centerY.equalTo(self)
        }
    }
    
    func setupCurrentScoresLabel() {
        self.addSubview(currentScoresLabel)
        currentScoresLabel.text = "1"
        currentScoresLabel.textColor = .black
        currentScoresLabel.font = UIFont.systemFont(ofSize: 55)
        currentScoresLabel.contentMode = .center
        currentScoresLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).offset(-35)
            make.centerY.equalTo(self).offset(-10)
        }
    }
    
    func setupCurrentScoresNameLabel() {
        self.addSubview(currentScoresNameLabel)
        currentScoresNameLabel.textColor = .black
        currentScoresNameLabel.text = "Очки"
        currentScoresNameLabel.font = UIFont.systemFont(ofSize: 15)
        currentScoresNameLabel.contentMode = .center
        currentScoresNameLabel.snp.makeConstraints { make in
            
            make.trailing.equalTo(self.snp.trailing).offset(-30)
            make.bottom.equalTo(self.snp.bottom).offset(-38)
        }
    }
}


