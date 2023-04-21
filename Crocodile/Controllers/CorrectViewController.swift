import Foundation
import UIKit
class CorrectViewController: UIViewController {
    
    let backgroundImage = UIImageView(image: UIImage(named: Resources.Image.backgroundImage))
    let greenRectangleImage = UIImageView(image: UIImage(named: Resources.Image.greenRectangle))
    let correctStarImage = UIImageView(image: UIImage(named: Resources.Image.correctStarImage))
    let teamInformationImage = UIImageView(image: UIImage(named: Resources.Image.teamInformationImage))
    var pictureTeamImage = UIImageView(image: UIImage(named: Resources.Image.cowboyImage))
    let teamNameLabel = UILabel()
    let congratulationsLabel = UILabel() // "Поздравляем"
    let youGetLabel = UILabel() // "Вы получаете"
    let nameScoreLabel = UILabel() // "ОЧКИ"
    var nextMoveLabel = UILabel() // "Слудующий ход - "ИМЯ КОМАНДЫ""
    var scoresLabel = UILabel()
    let scoresNameLabel = UILabel() // Очки
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupGreenRectangleImage()
        setupCongratulationsLabel()
        setupYouGetLabel()
        setupCorrectStarImage()
        setupNameScoreLabel()
        setupNextMoveLabel()
        setupTeamInformationImage()
        setupPictureTeamImage()
        setupTeamNameLabel()
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
    
    // Зеленый Прямоугольник
    func setupGreenRectangleImage() {
        view.addSubview(greenRectangleImage)
        greenRectangleImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(275)
            make.centerX.equalToSuperview()
            
            make.height.equalTo(325)
            make.left.equalTo(12)
            

        }
    }
    // Поздравляем
    func setupCongratulationsLabel(){
        view.addSubview(congratulationsLabel)
        congratulationsLabel.text = "Поздравляем"
        congratulationsLabel.font = UIFont.boldSystemFont(ofSize: 28)
        congratulationsLabel.contentMode = .center
        congratulationsLabel.textColor = .black
        
        
        congratulationsLabel.snp.makeConstraints { make in
            
            //Если это добавить, то размещается не по центру
//            make.width.equalTo(203)
            
            //Указаный размер на макете маловат
            //make.height.equalTo(22)
            make.height.equalTo(28)
            
            make.top.equalTo(greenRectangleImage.snp.top).offset(47)
            make.centerX.equalToSuperview()
            
        }
    }
    // Вы получаете
    func setupYouGetLabel() {
        view.addSubview(youGetLabel)
        youGetLabel.text = "Вы получаете"
        youGetLabel.font = UIFont.systemFont(ofSize: 16)
        youGetLabel.contentMode = .center
        youGetLabel.textColor = .black
        
        youGetLabel.snp.makeConstraints { make in
            // маленькое расстояние получается между "Поздравляем" и "Вы получаете" если делать по макету
            //make.top.equalTo(congratulationsLabel.snp.top).offset(24)
            make.top.equalTo(congratulationsLabel.snp.top).offset(55)
            make.centerX.equalToSuperview()
        }
    }
    
    // звезда
    func setupCorrectStarImage() {
        view.addSubview(correctStarImage)
        correctStarImage.snp.makeConstraints { make in
            //расстояние от "Вы получаете" должно быть 3,48) но оно получается слишком маленьким
            make.top.equalTo(youGetLabel.snp.top).offset(8)
            make.centerX.equalToSuperview()
            // длинну и ширину не выставлял, т.к. получается вытянутая звезда
        }
    }
    
    
    // не понимаю почему в фигме добавляется одно ОЧКИ, а написано ОЧКИ
    // мб это исправить?
    
    func setupNameScoreLabel() {
        view.addSubview(nameScoreLabel)
        nameScoreLabel.text = "ОЧКИ"
        nameScoreLabel.textColor = .yellow
        nameScoreLabel.font = UIFont.systemFont(ofSize: 13)
        nameScoreLabel.contentMode = .center
        
        nameScoreLabel.snp.makeConstraints { make in
            
            // тоже примерное расстояние(в Figma 89)
            make.top.equalTo(correctStarImage.snp.top).offset(106)
            
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
            
            // вот тут опять расстояние примерное
            make.top.equalTo(nameScoreLabel.snp.bottom).offset(20)
            make.bottom.equalTo(greenRectangleImage.snp.bottom).offset(-44)
            make.centerX.equalToSuperview()
        }
    }
    
    // белый прямоугольник сверху
    func setupTeamInformationImage() {
        view.addSubview(teamInformationImage)
        teamInformationImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
            make.left.equalToSuperview()
            make.bottom.equalTo(greenRectangleImage.snp.top).offset(-58)
            
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
    
    func setupScoresLabel() {
        print()
    }
    
    
    
    
}
