//
//  TeamVC.swift
//  Crocodile
//
//  Created by Kovs on 22.04.2023.
//

import UIKit

class TeamVC: UIViewController {
    
    let backgroundImage = UIImage(named: "backgroundImage")
    var teamName = Info.getNameTeam()
    
    // MARK: - Private properties
    var collectionView: UICollectionView = {
        
        let layot = UICollectionViewFlowLayout()
        layot.scrollDirection = .vertical
        layot.minimumInteritemSpacing = 16
        layot.minimumLineSpacing = 16
        layot.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layot.itemSize = CGSize(width: 351, height: 96)
        
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layot)
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
            let image = self.randomImageName()
            let newName = Info(name: name, image: image )
            self.teamName.append(newName)
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
            let name = self.teamName[indexPath.item]
            textField.text = name.name
        }
        
        
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {[weak self] _ in
            guard let self = self,
                  let newName = alertController.textFields?.first?.text else { return }
            self.teamName[indexPath.item].name = newName
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
            teamName.remove(at: indexPath.item)
            collectionView.deleteItems(at: [indexPath])
        }
    }
    
    // MARK: - Button to the next screen "Category"
    
    @objc func buttonPressed() {
        
        let categoryVC = CategoryViewController()
        navigationController?.pushViewController(categoryVC, animated: true)
        
    }
    
}



