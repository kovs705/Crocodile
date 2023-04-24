//
//  CategoryVC.swift
//  Crocodile
//
//  Created by Kovs on 22.04.2023.
//

import UIKit

class CategoryVC: UIViewController {
    
    var categoriesWords: [String] = []
    
    let backgroundImage = UIImage(named: "backgroundImage")
    var categories = Category.getCategory()
    var selectedCellIndex: [Int] = []
    
    var teams: [Team] = []
    
    var collectionView: UICollectionView = {
        
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.collectionView?.alwaysBounceVertical = true
        layout.collectionView?.isScrollEnabled = true
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: 351, height: 96)
        
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.backgroundColor = .clear
        
        return collectionV
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать игру", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5230828524, green: 0.7005900741, blue: 0.2440984249, alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    
    @objc func buttonPressed() {
        
        if selectedCellIndex.count == 0 {
            showAlertNoWords()
            return
        }
        
        for number in selectedCellIndex {
            for category in categories {
                if category.index == number {
                    categoriesWords += category.words
                }
            }
        }
        
        
        print(categoriesWords)
        
        let gameVC = GameViewController(teams: self.teams, team: self.teams.first, words: categoriesWords)
        navigationController?.pushViewController(gameVC, animated: true)
    }
    
    func getTeams() {
        TeamManager.shared.getTeams { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let teams):
                self.teams = teams
            case .failure(let error):
                fatalError(error.rawValue)
            }
        }
    }
    
    
    func setImageCollection() {
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFit
        collectionView.backgroundView = backgroundImageView
    }
    
    func showAlertNoWords() {
        let alertController = UIAlertController(title: "Внимание", message: "Для интересной игры выберите пожалуйста хотя бы одну категорию!", preferredStyle: .alert)
        
        let alertCancel = UIAlertAction(title: "Хорошо!", style: .cancel) { _ in }
        
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
}
