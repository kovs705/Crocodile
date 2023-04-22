//
//  RoolsViewController.swift
//  Crocodile
//
//  Created by Kovs on 17.04.2023.
//


import UIKit

class RoolsViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating & customazing background
        let backgroundImage = UIImageView(image: UIImage(named: Resources.Image.backgroundImage))
        
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        
        // Creating ScrollView
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = false
        scrollView.bounces = true
        scrollView.contentSize = self.view.frame.size
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(80)
        }
        // Creating label with game rules
        let rulesText = UILabel()
        rulesText.text = howToPlayText
        rulesText.numberOfLines = 0
    
        scrollView.addSubview(rulesText)
        rulesText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
    }

    
   // Rules
    let howToPlayText = """
В игру играют командами из двух или более человек.
           
Задача каждого игрока команды - объяснить слово, которое он видит на экране, следуя условиям, которые дополнительно указаны под
загаданным словом.
            
Чем больше слов отгадала команда, тем больше она заработает баллов.

Выигрывает команда, набравшая больше всего баллов.

На отгадывание слова дается одна минута.

При нарушении правил объяснения слова, ход передается следующей команде.

....

....

"""
    }

