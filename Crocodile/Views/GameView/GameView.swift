//
//  GameView.swift
//  Crocodile
//
//  Created by Админ on 17.04.2023.
//

import UIKit
import SnapKit

protocol SelectorAnswerDelegate: AnyObject {
    func resetButtonDidTapped(_ header: GameView)
    func rightButtonDidTapped(_ header: GameView)
    func wrongButtonDidTapped(_ header: GameView)
}

final class GameView: UIView {
    
    weak var delegate: SelectorAnswerDelegate?
    
    private let bacgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "backgroundImage")
        view.contentMode = .scaleToFill
        return view
    }()
    
    private let crocImage: UIImageView = {
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
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "объясни с помощью жестов"
        label.font = .systemFont(ofSize: 25, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var greenGameButton : UIButton = {
        let button = UIButton ()
        button.setTitle("Правильно", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.523082912, green: 0.7005900741, blue: 0.2440984249, alpha: 1)
        return button
    }()
    
    private lazy var redGameButton : UIButton = {
        let button = UIButton ()
        button.setTitle("Нарушил правила", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.2745098039, blue: 0.2745098039, alpha: 1)
        return button
    }()
    
    private lazy var grayGameButton : UIButton = {
        let button = UIButton ()
        button.setTitle("Сбросить", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5490196078, green: 0.568627451, blue: 0.5882352941, alpha: 1)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setTargetToButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bacgroundView.frame = bounds
        
    }
    
    //MARK: - configure button delegate
    
    private func setTargetToButton() {
        greenGameButton.addTarget(self, action: #selector(rightButtonDidTapped), for: .touchUpInside)
        redGameButton.addTarget(self, action: #selector(wrongButtonDidTapped), for: .touchUpInside)
        grayGameButton.addTarget(self, action: #selector(resetButtonDidTapped), for: .touchUpInside)
        
    }
    
    @objc private func rightButtonDidTapped() {
        delegate?.rightButtonDidTapped(self)
        greenGameButton.blink()
    }
    
    @objc private func wrongButtonDidTapped() {
        delegate?.wrongButtonDidTapped(self)
        redGameButton.blink()
    }
    
    @objc private func resetButtonDidTapped() {
        delegate?.resetButtonDidTapped(self)
        grayGameButton.blink()
    }
}

//MARK: - extension

extension GameView {
    private func setupViews() {
        [bacgroundView,crocImage,timerLabel, mainWordLabel, descriptionLabel, greenGameButton, redGameButton, grayGameButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        [ greenGameButton, redGameButton, grayGameButton].forEach {
            $0.layer.shadowOpacity = 1
            $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            $0.layer.shadowOffset = CGSize(width: 5, height: 5)
            $0.layer.shadowRadius = 5
            $0.layer.cornerRadius = 15
            $0.layer.masksToBounds = false
            $0.tintColor = .white
            $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        }
        
        crocImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview().inset(120)
            make.bottom.equalToSuperview().inset(642)
            make.top.equalToSuperview().inset(60)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(crocImage).inset(90)
            make.centerX.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(450)
        }
        
        mainWordLabel.snp.makeConstraints { make in
            make.top.equalTo(timerLabel).inset(210)
            make.centerX.equalToSuperview().inset(65)
            make.height.equalTo(70)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().inset(89)
            make.bottom.equalTo(mainWordLabel).inset(-70)
            make.height.equalTo(70)
        }
        
        greenGameButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(567)
            make.right.left.equalToSuperview().inset(12)
            make.height.equalTo(70)
        }
        
        redGameButton.snp.makeConstraints { make in
            make.bottom.equalTo(greenGameButton).inset(-85)
            make.right.left.equalToSuperview().inset(12)
            make.height.equalTo(70)
        }
        
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

extension UIButton {
    func blink(enabled: Bool = true, duration: CFTimeInterval = 0.1, stopAfter: CFTimeInterval = 0.4 ) {
        enabled ? (UIView.animate(
            withDuration: duration,
            delay: 0.0,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: { [weak self] in self?.alpha = 0.8 },
            completion: { [weak self] _ in self?.alpha = 1.0 })) : self.layer.removeAllAnimations()
        
        if !stopAfter.isEqual(to: 0.0) && enabled {
            DispatchQueue.main.asyncAfter(deadline: .now() + stopAfter) { [weak self] in
                self?.layer.removeAllAnimations()
            }
        }
    }
}








//import SwiftUI
//
//struct PeopleVCProvider: PreviewProvider {
//    static var previews: some View {
//        Container().edgesIgnoringSafeArea(.all)
//            .previewDevice("iPhone 14 Pro ")
//    }
//
//    struct Container: UIViewControllerRepresentable {
//
//        let tabBarVC = GameViewController()
//
//        func makeUIViewController(context: Context) -> some UIViewController {
//            tabBarVC
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//        }
//    }
//}

