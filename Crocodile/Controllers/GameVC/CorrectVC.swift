//
//  CorrectVC.swift
//  Crocodile
//
//  Created by Kovs on 21.04.2023.
//

import UIKit

class CorrectViewController: UIViewController {
    
    var win: Bool!
    var isLast: Bool!
    var team: Team!
    
    var teams: [Team] = []
    
    var correctView = CorrectWrongView(greetOrLose: true, teamName: "Test", isLast: true, team: Team(emoji: "", backColor: "", name: "", score: 0))
    
    let backgroundImage = UIImageView(image: UIImage(named: Resources.Image.backgroundImage))
    let teamInformationImage = UIImageView(image: UIImage(named: Resources.Image.teamInformationImage))
    
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
    
    let teamNameLabel = UILabel()
    
    var currentScoresLabel = UILabel()
    let currentScoresNameLabel = UILabel() // Очки
    let oneScoreLabel = UILabel()
    let passTheMoveButton = GreenButton(backgroundColor: Resources.Colors.greenButtonColor, title: "Передать ход")
    
    let screenBounds = UIScreen.main.bounds
    
    init(win: Bool, isLast: Bool, team: Team) {
        super.init(nibName: nil, bundle: nil)
        
        self.win = win
        self.isLast = isLast
        self.team = team
        
        if teamIndex <= teams.count - 1 {
            correctView = CorrectWrongView(greetOrLose: win, teamName: teams[teamIndex + 1].name, isLast: isLast, team: team)
        } else {
            correctView = CorrectWrongView(greetOrLose: win, teamName: teams[0].name, isLast: isLast, team: team)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem?.isEnabled = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTeams()
        
        setupBackgroundImage()
        setupTeamInformationImage()
        
        setupPictureTeamImage()
        setupTeamNameLabel()
        setupCurrentScoresLabel()
        setupCurrentScoresNameLabel()
        
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
        teamNameLabel.text = team.name
        teamNameLabel.textColor = .black
        teamNameLabel.font = UIFont.systemFont(ofSize: 20)
        teamNameLabel.contentMode = .center
        teamNameLabel.snp.makeConstraints { make in
            make.left.equalTo(teamView.snp.right).offset(34)
            make.centerY.equalTo(teamInformationImage)
        }
    }
    
    // картинка комманды
    func setupPictureTeamImage() {
        view.addSubview(teamView)
        teamView.snp.makeConstraints { make in
            make.left.equalTo(teamInformationImage.snp.left).offset(55)
            make.centerY.equalTo(teamInformationImage)
        }
        
        teamView.addSubview(teamEmoji)
        teamEmoji.snp.makeConstraints { make in
            make.centerX.equalTo(teamView)
            make.centerY.equalTo(teamView)
        }
        
        teamView.backgroundColor = UIColor(named: team.backColor)
        teamEmoji.text = team.emoji
    }
    
    func setupCurrentScoresLabel() {
        view.addSubview(currentScoresLabel)
        currentScoresLabel.text = String(team.score)
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
            
            make.right.equalTo(teamInformationImage.snp.right).offset(-45)
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
        
        passTheMoveButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
    }
    
    @objc func closeVC() {
        navigationController?.popViewController(animated: true)
        if numberOfMoves <= 10 {
            if teamIndex >= teams.count - 1 {
                teamIndex = 0
                print(teamIndex)
            } else {
                teamIndex += 1
                numberOfMoves += 1
                print(teamIndex)
            }
        } else {
            let results = GameResultsViewController()
            navigationController?.pushViewController(results, animated: true)
        }
    }
    
}
