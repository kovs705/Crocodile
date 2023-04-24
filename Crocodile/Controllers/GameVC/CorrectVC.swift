//
//  CorrectVC.swift
//  Crocodile
//
//  Created by Kovs on 21.04.2023.
//

import UIKit

class CorrectViewController: UIViewController {
    
    let win: Bool!
    let isLast: Bool!
    let team: Team!
    
    let correctView = CorrectWrongView(greetOrLose: win, teamName: "Test")
    
    let backgroundImage = UIImageView(image: UIImage(named: Resources.Image.backgroundImage))
    
    let teamInformationImage = UIImageView(image: UIImage(named: Resources.Image.teamInformationImage))
    var pictureTeamImage = UIImageView(image: UIImage(named: Resources.Image.cowboyImage))
    let teamNameLabel = UILabel()
    
    var currentScoresLabel = UILabel()
    let currentScoresNameLabel = UILabel() // Очки
    let oneScoreLabel = UILabel()
    let passTheMoveButton = GreenButton(title: "Передать ход")
    
    let screenBounds = UIScreen.main.bounds
    
    init(win: Bool, isLast: Bool, team: Team) {
        self.win = win
        self.isLast = isLast
        self.team = team
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundImage()
        setupTeamInformationImage()
        
        setupPictureTeamImage()
        setupTeamNameLabel()
        setupCurrentScoresLabel()
        
        setupPassTheMoveButton()
        
        view.addSubview(correctView)
        
        correctView.snp.makeConstraints { make in
            
            make.top.equalTo(teamInformationImage.snp.bottom).offset(50)
            make.leading.equalTo(view.snp.leading).offset(10)
            
            make.height.equalTo(view.frame.height * 0.33)
            make.width.equalTo(view.frame.width - 20)
        }
        
        // self.frame = CGRectMake(10, screenBounds.height - (screenBounds.height / 2.8), screenBounds.width - 20, screenBounds.height / 2.8)

    }
    
    func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // белый прямоугольник сверху
    func setupTeamInformationImage() {
        view.addSubview(teamInformationImage)
        teamInformationImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
            make.left.equalToSuperview()
        }
    }
    
    // имя команды
    func setupTeamNameLabel() {
        view.addSubview(teamNameLabel)
        teamNameLabel.text = "Ковбои"
        teamNameLabel.textColor = .black
        teamNameLabel.font = UIFont.systemFont(ofSize: 20)
        teamNameLabel.contentMode = .center
        teamNameLabel.snp.makeConstraints { make in
            make.left.equalTo(pictureTeamImage.snp.right).offset(34)
            make.centerY.equalTo(teamInformationImage)
        }
    }
    
    // картинка комманды
    func setupPictureTeamImage() {
        view.addSubview(pictureTeamImage)
        pictureTeamImage.snp.makeConstraints { make in
            make.width.equalTo(56)
            make.height.equalTo(56)
            make.left.equalTo(teamInformationImage.snp.left).offset(27)
            make.centerY.equalTo(teamInformationImage)
        }
    }
    
    func setupCurrentScoresLabel() {
        view.addSubview(currentScoresLabel)
        currentScoresLabel.text = "1"
        currentScoresLabel.textColor = .black
        currentScoresLabel.font = UIFont.systemFont(ofSize: 55)
        currentScoresLabel.contentMode = .center
        currentScoresLabel.snp.makeConstraints { make in
            make.right.equalTo(teamInformationImage.snp.right).offset(-35)
            make.centerY.equalTo(teamInformationImage).offset(-10)
        }
    }
    
    func setupCurrentScoresNameLabel() {
        view.addSubview(currentScoresNameLabel)
        currentScoresNameLabel.textColor = .black
        currentScoresNameLabel.text = "Очки"
        currentScoresNameLabel.font = UIFont.systemFont(ofSize: 15)
        currentScoresNameLabel.contentMode = .center
        currentScoresNameLabel.snp.makeConstraints { make in
            
            make.right.equalTo(teamInformationImage.snp.right).offset(-30)
            make.bottom.equalTo(teamInformationImage.snp.bottom).offset(-38)
        }
    }
    
    func setupPassTheMoveButton() {
        view.addSubview(passTheMoveButton)
        passTheMoveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-46)
            make.height.equalTo(60)
        }
    }
    
    
    
}
