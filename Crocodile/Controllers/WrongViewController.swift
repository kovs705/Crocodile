import Foundation
import UIKit
class WrongViewController: UIViewController {
    
    let backgroundImage = UIImageView(image: UIImage(named: Resources.Image.backgroundImage))
    let redRectangleImage = UIImageView(image: UIImage(named: Resources.Image.redRectangleImage))
    let eclipseImage = UIImageView(image: UIImage(named: Resources.Image.eclipseImage))
    let teamInformationImage = UIImageView(image: UIImage(named: Resources.Image.teamInformationImage))
    var pictureTeamImage = UIImageView(image: UIImage(named: Resources.Image.cowboyImage))
    let teamNameLabel = UILabel()
    let ohhLabel = UILabel() //
    let youDontGetLabel = UILabel() //
    let nameScoreLabel = UILabel() // "ОЧКИ"
    var nextMoveLabel = UILabel() // "Следующий ход - "ИМЯ КОМАНДЫ""
    var currentScoresLabel = UILabel()
    let currentScoresNameLabel = UILabel() // Очки
    let zeroScoreLabel = UILabel()
    let passTheMoveButton = GreenButton(backgroundColor: Resources.Colors.greenButtonColor, title: "Передать ход")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupRedRectangleImage()
        setupOhhLabel()
        setupYouDontGetLabel()
        setupEclipseImage()
        setupNextMoveLabel()
        setupZeroScoreLabel()
        setupPassTheMoveButton()
        setupTeamInformationImage()
        setupPictureTeamImage()
        setupTeamNameLabel()
        setupCurrentScoresLabel()
        setupCurrentScoresNameLabel()
    }
    
    func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    // Красный Прямоугольник
    func setupRedRectangleImage() {
        view.addSubview(redRectangleImage)
        redRectangleImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(275)
            make.centerX.equalToSuperview()
            
            make.height.equalTo(325)
            make.left.equalTo(12)
            
            
        }
    }
    // Увы и ах
    func setupOhhLabel(){
        view.addSubview(ohhLabel)
        ohhLabel.text = "УВЫ И АХ!"
        ohhLabel.font = UIFont.boldSystemFont(ofSize: 28)
        ohhLabel.contentMode = .center
        ohhLabel.textColor = .black
        
        ohhLabel.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.top.equalTo(redRectangleImage.snp.top).offset(47)
            make.centerX.equalToSuperview()
            
        }
    }
    // Вы не отгадали слово и не получаете очков!
    func setupYouDontGetLabel() {
        view.addSubview(youDontGetLabel)
        youDontGetLabel.text = "Вы не отгадали слово и не получаете очков!"
        youDontGetLabel.font = UIFont.systemFont(ofSize: 16)
        youDontGetLabel.contentMode = .center
        youDontGetLabel.textColor = .black
        youDontGetLabel.numberOfLines = 0
        youDontGetLabel.textAlignment = .center
        
        youDontGetLabel.snp.makeConstraints { make in
            make.top.equalTo(ohhLabel.snp.bottom).offset(28)
            make.left.equalTo(redRectangleImage.snp.left).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupEclipseImage() {
        view.addSubview(eclipseImage)
        eclipseImage.snp.makeConstraints { make in
            
            make.top.equalTo(youDontGetLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    //Cледующий ход - ...
    func setupNextMoveLabel() {
        view.addSubview(nextMoveLabel)
        nextMoveLabel.text = "Следующий ход - \"ИМЯ КОМАНДЫ\""
        nextMoveLabel.textColor = .black
        nextMoveLabel.font = UIFont.systemFont(ofSize: 16)
        nextMoveLabel.contentMode = .center
        
        nextMoveLabel.snp.makeConstraints { make in
            
            make.top.equalTo(eclipseImage.snp.bottom).offset(10)
            
            make.centerX.equalToSuperview()
        }
    }
    
    // O
    func setupZeroScoreLabel() {
        view.addSubview(zeroScoreLabel)
        zeroScoreLabel.text = "0"
        zeroScoreLabel.contentMode = .center
        zeroScoreLabel.font = UIFont.systemFont(ofSize: 60)
        zeroScoreLabel.textColor = .white
        zeroScoreLabel.snp.makeConstraints { make in
            make.centerX.equalTo(eclipseImage)
            make.centerY.equalTo(eclipseImage)
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
    
    // белый прямоугольник сверху
    func setupTeamInformationImage() {
        view.addSubview(teamInformationImage)
        teamInformationImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
            make.left.equalToSuperview()
            make.bottom.equalTo(redRectangleImage.snp.top).offset(-58)
            
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
    
    func setupCurrentScoresLabel() {
        view.addSubview(currentScoresLabel)
        currentScoresLabel.text = "2"
        currentScoresLabel.textColor = .black
        currentScoresLabel.font = UIFont.systemFont(ofSize: 55)
        currentScoresLabel.contentMode = .center
        currentScoresLabel.snp.makeConstraints { make in
            make.right.equalTo(teamInformationImage.snp.right).offset(-30)
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
    
}
