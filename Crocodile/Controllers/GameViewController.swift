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
    private var isTimerRunning = false
    
    override func loadView() {
        super.loadView()
        self.view = gameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.delegate = self
        runTimer()
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
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
        musicPlayer.playSound(nameOfMusic: "win")
        
    }
    
    func wrongButtonDidTapped(_ header: GameView) {
        print("Ответ не верный")
        musicPlayer.playSound(nameOfMusic: "lost")
    }
    
    func resetButtonDidTapped(_ header: GameView) {
        let alertController = UIAlertController(title: "Сбросить игру?", message: "Вы хотите сбросить прогресс вашей игры и вернуться в главное меню?", preferredStyle: .alert)
        
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        let alertCancel = UIAlertAction(title: "Отмена", style: .default) { _ in
        }
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
}
