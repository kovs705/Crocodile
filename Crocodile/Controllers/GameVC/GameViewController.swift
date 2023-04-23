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
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        remindTimer = Timer.scheduledTimer(timeInterval: 50, target: self, selector: #selector(reminderTenSecond), userInfo: nil, repeats: false)
    }
    
    @objc private func reminderTenSecond() {
        musicPlayer.playSound(nameOfMusic: "321")
    }
    
    @objc private func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            // что тут должно быть?
        } else {
            seconds -= 1
            gameView.timerLabel.text = gameView.timeString(time: TimeInterval(seconds))
        }
        
    }
    
}

extension GameViewController: SelectorAnswerDelegate {
    
    func rightButtonDidTapped(_ header: GameView) {
        print("Ответ верный")
        
        
//        let vcEND = GameResultsViewController()
//        navigationController?.pushViewController(vcEND, animated: true)
        
        musicPlayer.playSound(nameOfMusic: "win")
        
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
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            print("переход на следующий экарн")
            // делаем транзишн на экран проигрыша и зачисления 0 балов
        }
        
    }
    
    func resetButtonDidTapped(_ header: GameView) {
        let alertController = UIAlertController(title: "Сбросить игру?", message: "Вы хотите сбросить прогресс вашей игры и вернуться в главное меню?", preferredStyle: .alert)
        
        let alertOk = UIAlertAction(title: "Ok", style: .default) {_ in
            TeamManager.shared.updateWith(team: self.teams, action: .remove) { [weak self] result in
                guard let self = self else { return }
                TeamManager.shared.getTeams { team in
                    switch team {
                    case.failure(let error):
                        print(error.localizedDescription)
                        
                    case .success(let teamModel):
                        print(teamModel)
                        print("Данные о командах сброшены")
                        self.timer.invalidate()
                    }
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
