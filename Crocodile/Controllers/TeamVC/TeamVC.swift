//
//  TeamVC.swift
//  Crocodile
//
//  Created by Kovs on 22.04.2023.
//

import UIKit

class TeamVC: UIViewController {
    
    let backgroundImage = UIImage(named: "backgroundImage")
    var teamObj: [Team] = []
    
    
    func getTeams() {
        TeamManager.shared.getTeams { [weak self ] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let teams):
                self.updateUI(with: teams)
            case .failure(let failure):
                fatalError(failure.rawValue)
            }
        }
    }
    
    func updateUI(with teams: [Team]) {
        if teams.isEmpty {
            print("No teams")
            // добавить две команды в UserDefaults по ключу "teams"
        } else {
            self.teamObj = teams
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Private properties
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
        button.setTitle("Игроки готовы", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5230828524, green: 0.7005900741, blue: 0.2440984249, alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - NavBar
    func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    // MARK: - Logic
    func randomImageName() -> String {
        let imageNames = ["2", "3", "4", "5", "6", "7", "8", "9"]
        return imageNames.randomElement() ?? ""
    }
    
    func setImageCollection() {
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        collectionView.backgroundView = backgroundImageView
    }
    
    
    // MARK: - Add Button Action
    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "Add Team", message: "Enter team name", preferredStyle: .alert)
        
        alertController.addTextField {
            textField in textField.placeholder = "Team name"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) {
            [weak self] _ in
            guard let self = self, let name = alertController.textFields?.first?.text else { return }
            
            let team = Team(emoji: emojies.randomElement()!, backColor: backColor.randomElement()!, name: name, score: 0)
            TeamManager.shared.updateWith(team: team, action: .add) { error in
                
                guard error != nil else {
                    // success:
                    print("Team - \(team) created successfully!")
                    self.updateUI(with: self.teamObj)
                    return
                }
                // failure:
                fatalError("failure on adding new team")
            }
            
            self.collectionView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: - Add button in cell "Edit"
    @objc func editButtonPressed(_ sender: UIButton) {
        
        guard let cell = sender.superview?.superview as? TeamCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else  { return }
        let alertController = UIAlertController(title: "Edit team name", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter new name"
            
            let team = self.teamObj[indexPath.item]
            
            TeamManager.shared.getTeams { result in
                switch result {
                case .success(var teamsArray):
                    guard teamsArray.contains(where: { $0.name == team.name && $0.emoji == team.emoji }) else {
                        return
                    }
                    
                    teamsArray = teamsArray.map { t in
                        if t.name == team.name && t.emoji == team.emoji {
                            return Team(emoji: t.emoji, backColor: t.backColor, name: textField.text!, score: t.score+1)
                        } else { return t }
                    }
                case .failure(_):
                    fatalError()
                }
            }
        }
        
        
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {[weak self] _ in
            guard let self = self,
                  let newName = alertController.textFields?.first?.text else { return }
            self.teamObj[indexPath.item].name = newName
            self.collectionView.reloadItems(at: [indexPath])
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    @objc func deleteButtonPressed(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? TeamCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else { return }
        if indexPath.item >= 2 {
            TeamManager.shared.updateWith(team: teamObj[indexPath.item], action: .remove) { [weak self] error in
                guard let self = self else { return }
                guard let error = error else {
                    // success:
                    self.teamObj.remove(at: indexPath.item)
                    self.collectionView.deleteItems(at: [indexPath])
                    return
                }
                // failure
                fatalError(error.rawValue)
            }
            
            
        }
    }
    
    // MARK: - Button to the next screen "Category"
    
    @objc func buttonPressed() {
        
        let categoryVC = CategoryViewController()
        navigationController?.pushViewController(categoryVC, animated: true)
        
    }
    
}



