//
//  CorrectWrongView.swift
//  Crocodile
//
//  Created by Kovs on 21.04.2023.
//

import UIKit

class CorrectWrongView: UIView {
    
    let greetLabel = UILabel()
    let getOrLoseLabel = UILabel()
    
    let winOrLostImage = UIImageView()
    let scoreLabel = UILabel()
    
    let nextMoveLabel = UILabel()
    let score = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(greetOrLose: Bool, teamName: String, isLast: Bool, team: Team) {
        self.init(frame: .zero)
        
        configureWinOrLose(isWin: greetOrLose, nextTeam: teamName, team: team)
    }
    
    
    // MARK: - Win or Lose:
    private func configureWinOrLose(isWin: Bool, nextTeam: String, team: Team) {
        
        self.backgroundColor = UIColor(named: isWin ? Resources.Colors.greenButtonColor : Resources.Colors.redColor)
        
        greetLabel.text = isWin ? "Поздравляем" : "УВЫ И АХ!"
        getOrLoseLabel.text = isWin ? "Вы получаете" : "Вы не отгадали слово и не получаете очков!"
        
        winOrLostImage.image = UIImage(named: isWin ? Resources.Image.correctStarImage : Resources.Image.wrongCircleImage)
        
        nextMoveLabel.text = "Следующий ход - \(nextTeam)"
        setupTeamNameLabel(team: team)
    }
    
    func setupTeamNameLabel(team: Team) {
        winOrLostImage.addSubview(scoreLabel)
        scoreLabel.text = String(team.score)
        scoreLabel.textColor = .black
        scoreLabel.font = UIFont.systemFont(ofSize: 20)
        scoreLabel.contentMode = .center
        scoreLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(winOrLostImage)
        }
    }
    
    
    // MARK: - Configuring stuff:
    private func configure() {
        // title
        placeGreetLabel()
        configureLabel(of: greetLabel, withSize: 28, textColor: .label, isBold: true)
        
        
        // get or lose the score
        placeGetOrLoseLabel()
        configureLabel(of: getOrLoseLabel, withSize: 16, textColor: .label, isBold: false)
        
        // image (star or circle if lost) and score under the image
        placeImageScore()
        placeScoreInsideImage()
        
        // next move
        placeNextMoveLabel()
        
        layer.cornerRadius = 15
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureLabel(of label: UILabel, withSize: CGFloat, textColor: UIColor, isBold: Bool) {
        label.contentMode = .center
        label.textAlignment = .center
        label.font = isBold ? UIFont.boldSystemFont(ofSize: withSize) : UIFont.systemFont(ofSize: withSize)
        label.textColor = .black
        
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func placeGreetLabel() {
        self.addSubview(greetLabel)
        
        greetLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(30)
            make.centerX.equalTo(self)
        }
    }
    
    private func placeGetOrLoseLabel() {
        self.addSubview(getOrLoseLabel)
        
        getOrLoseLabel.snp.makeConstraints { make in
            make.top.equalTo(greetLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }
    }
    
    private func placeImageScore() {
        self.addSubview(winOrLostImage)
        
        winOrLostImage.snp.makeConstraints { make in
            
            make.height.equalTo(100)
            make.width.equalTo(100)
            
            make.top.equalTo(getOrLoseLabel.snp.bottom).offset(8)
            make.centerX.equalTo(self)
        }
        
        winOrLostImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func placeScoreInsideImage() {
        winOrLostImage.addSubview(scoreLabel)
        
        configureLabel(of: scoreLabel, withSize: 13, textColor: .yellow, isBold: false)
        scoreLabel.text = "ОЧКИ"
        
        scoreLabel.snp.makeConstraints { make in
            make.centerX.equalTo(winOrLostImage)
            make.top.equalTo(winOrLostImage.snp.bottom).offset(-6)
        }
        
    }
    
    private func placeNextMoveLabel() {
        self.addSubview(nextMoveLabel)
        
        configureLabel(of: nextMoveLabel, withSize: 16, textColor: .black, isBold: false)
        
        nextMoveLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel).offset(35)
            make.centerX.equalTo(self)
        }
    }
    
    
    
    
}
