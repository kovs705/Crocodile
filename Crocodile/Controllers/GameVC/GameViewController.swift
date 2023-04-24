//
//  GameViewController.swift
//  Crocodile
//
//  Created by Kovs on 17.04.2023.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    private let gameView = GameView()
    private let musicPlayer = MusicModel()
    private var seconds = 60
    private var timer = Timer()
    private var remindTimer = Timer()
    private var isTimerRunning = false
    
    var teams: [Team]!
    var team: Team!
    var words: [String]!
    
    var teamIndex = 0
    var numberOfMoves = 0 // until 10
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = gameView
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.delegate = self
        runTimer()
    }
    
    init(teams: [Team]!, team: Team!, words: [String]!) {
        super.init(nibName: nil, bundle: nil)
        self.teams = teams
        self.team = team
        self.words = words
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        remindTimer = Timer.scheduledTimer(timeInterval: 50, target: self, selector: #selector(reminderTenSecond), userInfo: nil, repeats: false)
    }
    
    @objc private func reminderTenSecond() {
        musicPlayer.playSound(nameOfMusic: "321")
    }
    
    @objc private func updateTimer() {
        if seconds == 0 {
            
            timersInvalidate()
            
            if numberOfMoves >= 10 {
                let correctVC = CorrectViewController(win: false, isLast: true, team: team)
                show(correctVC, sender: self)
            } else {
                let correctVC = CorrectViewController(win: false, isLast: false, team: team)
                show(correctVC, sender: self)
            }
            
        } else {
            seconds -= 1
            gameView.timerLabel.text = gameView.timeString(time: TimeInterval(seconds))
        }
        
    }
    
    func timersInvalidate() {
        timer.invalidate()
        remindTimer.invalidate()
    }
    
}

extension GameViewController: SelectorAnswerDelegate {
    
    func rightButtonDidTapped(_ header: GameView) {
        print("Ответ верный")
        
        let correctVC = CorrectViewController(win: false, isLast: true, team: team)
        show(correctVC, sender: self)
        
        musicPlayer.playSound(nameOfMusic: "win")
        
        timersInvalidate()
        
        TeamManager.shared.updateWith(team: team, action: .plus) { result in
            TeamManager.getTeams { team in
                switch team {
                case .success(let team):
                    print(team)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            print("переход на следующий экарн")
            // делаем транзишн на экран победы и зачисления 1 балла с кол-вом общих балов за игру
        }
        
    }
    
    func wrongButtonDidTapped(_ header: GameView) {
        print("Ответ не верный")
        
        musicPlayer.playSound(nameOfMusic: "lost")
        
        timersInvalidate()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            print("переход на следующий экарн")
            // делаем транзишн на экран проигрыша и зачисления 0 балов
        }
        
    }
    
    func resetButtonDidTapped(_ header: GameView) {
        let alertController = UIAlertController(title: "Сбросить игру?", message: "Вы хотите сбросить прогресс вашей игры и вернуться в главное меню?", preferredStyle: .alert)
        
        let alertOk = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            guard let self = self else { return }
            TeamManager.shared.getTeams { team in
                switch team {
                case.failure(let error):
                    print(error.localizedDescription)
                    
                case .success(let teamModel):
                    print(teamModel)
                    print("Данные о командах сброшены")
                    
                    self.timersInvalidate()
                }
            }
        }
        let alertCancel = UIAlertAction(title: "Отмена", style: .default) { _ in
        }
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
}
