//
//  GameVC.swift
//  Crocodile
//
//  Created by Kovs on 24.04.2023.
//

import UIKit
import SnapKit

protocol SelectorAnswerDelegate: AnyObject {
    func resetButtonDidTapped(_ header: GameVC)
    func rightButtonDidTapped(_ header: GameVC)
    func wrongButtonDidTapped(_ header: GameVC)
}

public var teamIndex = 0
public var numberOfMoves = 0

class GameVC: UIViewController {
    
    weak var delegate: SelectorAnswerDelegate?
    
    let musicPlayer = MusicModel()
    var seconds = 60
    var timer = Timer()
    var remindTimer = Timer()
    var isTimerRunning = false
    
    var variations = Category.getActions()
    
    var teams: [Team]!
    var team: Team!
    var words: [String]!
    
     // until 10
    var numberOfTries = 3
    
    var numberOverall = 0
    var teamsCount = 0
    
    
    
    
    
    func timersInvalidate() {
        timer.invalidate()
        remindTimer.invalidate()
    }
    
    let bacgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "backgroundImage")
        view.contentMode = .scaleToFill
        return view
    }()
    
    let crocImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "croc")
        return image
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "01:00"
        label.font = .systemFont(ofSize: 55, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    lazy var mainWordLabel: UILabel = {
        let label = UILabel()
        label.text = "Картошка"
        label.font = .systemFont(ofSize: 55, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var variationLabel: UILabel = {
        let label = UILabel()
        label.text = "объясни с помощью жестов"
        label.font = .systemFont(ofSize: 25, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var greenGameButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Правильно", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.523082912, green: 0.7005900741, blue: 0.2440984249, alpha: 1)
        return button
    }()
    
    lazy var redGameButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Нарушил правила", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.2745098039, blue: 0.2745098039, alpha: 1)
        return button
    }()
    
    lazy var grayGameButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сбросить", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5490196078, green: 0.568627451, blue: 0.5882352941, alpha: 1)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setTargetToButton()
    }
    
    //MARK: - configure button delegate
    
    func setTargetToButton() {
        greenGameButton.addTarget(self, action: #selector(rightButtonDidTapped), for: .touchUpInside)
        redGameButton.addTarget(self, action: #selector(wrongButtonDidTapped), for: .touchUpInside)
        grayGameButton.addTarget(self, action: #selector(resetButtonDidTapped), for: .touchUpInside)
        
    }
}

extension GameVC {
    func setupViews() {
        bacgroundView.translatesAutoresizingMaskIntoConstraints = false
        crocImage.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        mainWordLabel.translatesAutoresizingMaskIntoConstraints = false
        variationLabel.translatesAutoresizingMaskIntoConstraints = false
        greenGameButton.translatesAutoresizingMaskIntoConstraints = false
        redGameButton.translatesAutoresizingMaskIntoConstraints = false
        grayGameButton.translatesAutoresizingMaskIntoConstraints = false
        
        [ greenGameButton, redGameButton, grayGameButton].forEach {
            $0.layer.shadowOpacity = 1
            $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            $0.layer.shadowOffset = CGSize(width: 5, height: 5)
            $0.layer.shadowRadius = 5
            $0.layer.cornerRadius = 15
            $0.layer.masksToBounds = false
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        }
        
        view.addSubview(bacgroundView)
        bacgroundView.snp.makeConstraints { make in
            make.bottom.left.right.top.equalToSuperview()
        }
        
        view.addSubview(crocImage)
        crocImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview().inset(120)
            make.bottom.equalToSuperview().inset(642)
            make.top.equalToSuperview().inset(60)
        }
        
        view.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(crocImage).inset(90)
            make.centerX.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(450)
        }
        
        view.addSubview(mainWordLabel)
        mainWordLabel.snp.makeConstraints { make in
            make.top.equalTo(timerLabel).inset(210)
            make.centerX.equalToSuperview().inset(65)
            make.height.equalTo(70)
        }
        
        view.addSubview(variationLabel)
        variationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().inset(89)
            make.bottom.equalTo(mainWordLabel).inset(-70)
            make.height.equalTo(70)
        }
        
        view.addSubview(greenGameButton)
        greenGameButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(567)
            make.right.left.equalToSuperview().inset(12)
            make.height.equalTo(70)
        }
        
        view.addSubview(redGameButton)
        redGameButton.snp.makeConstraints { make in
            make.bottom.equalTo(greenGameButton).inset(-85)
            make.right.left.equalToSuperview().inset(12)
            make.height.equalTo(70)
        }
        
        view.addSubview(grayGameButton)
        grayGameButton.snp.makeConstraints { make in
            make.bottom.equalTo(redGameButton).inset(-85)
            make.right.left.equalToSuperview().inset(12)
            make.height.equalTo(70)
        }
        
    }
    
    func timeString(time:TimeInterval) -> String {
        
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i", minutes, seconds)
        
    }
    
}


