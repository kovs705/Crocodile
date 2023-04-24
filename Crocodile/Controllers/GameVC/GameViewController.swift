//
//  GameViewController.swift
//  Crocodile
//
//  Created by Kovs on 17.04.2023.
//

import Foundation
import UIKit

class GameViewController: GameVC {
    
    init(teams: [Team]!, team: Team!, words: [String]!) {
        super.init(nibName: nil, bundle: nil)
        self.teams = teams
        self.team = team
        self.words = words
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        super.loadView()
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        variationLabel.text = variations.randomElement()
        mainWordLabel.text = words.randomElement()
        runTimer()
        timerLabel.text = "01:00"
        seconds = 60
        
        team = teams[teamIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOverall = teams.count * numberOfTries
        teamsCount = teams.count
        print(numberOverall)
        print(teamsCount)
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        remindTimer = Timer.scheduledTimer(timeInterval: 49, target: self, selector: #selector(reminderTenSecond), userInfo: nil, repeats: false)
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
            self.timerLabel.text = self.timeString(time: TimeInterval(seconds))
        }
        
    }
    
    
    
}

extension GameVC {
    
    @objc func rightButtonDidTapped(_ header: GameVC) {
        timersInvalidate()
        print("Ответ верный")
        greenGameButton.blink()
        
        
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
        
        let correctVC = CorrectViewController(win: true, isLast: false, team: team)
        show(correctVC, sender: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            print("переход на следующий экран")
            // делаем транзишн на экран победы и зачисления 1 балла с кол-вом общих балов за игру
        }
        
    }
    
    
    @objc func wrongButtonDidTapped(_ header: GameVC) {
        timersInvalidate()
        print("Ответ не верный")
        redGameButton.blink()
        
        musicPlayer.playSound(nameOfMusic: "lost")
        
        let wrongVC = CorrectViewController(win: false, isLast: false, team: team)
        show(wrongVC, sender: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            print("переход на следующий экарн")
            // делаем транзишн на экран проигрыша и зачисления 0 балов
        }
        
    }
    
    @objc func resetButtonDidTapped(_ header: GameVC) {
        timersInvalidate()
        grayGameButton.blink()
        
        let alertController = UIAlertController(title: "Сбросить игру?", message: "Вы хотите сбросить прогресс вашей игры и вернуться в главное меню?", preferredStyle: .alert)
        
        let alertOk = UIAlertAction(title: "Ok", style: .default) { _ in
            TeamManager.shared.getTeams { team in
                switch team {
                case.failure(let error):
                    print(error.localizedDescription)
                    
                case .success(let teamModel):
                    print(teamModel)
                    print("Данные о командах сброшены")
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
