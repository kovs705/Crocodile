//
//  TeamViewController.swift
//  Crocodile
//
//  Created by mac on 4/20/23.
//

import UIKit
import SnapKit

class TeamViewController: UIViewController {
    
    // MARK: - Properties
    
    let backgroundImage = UIImage(named: "backgroundImage")
    var teamName = Info.getNameTeam()
    var info: [Info] = []
    
    // MARK: - Private properties
    
    private var collectionView: UICollectionView = {
        
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
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Игроки готовы", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5230828524, green: 0.7005900741, blue: 0.2440984249, alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Private constants
    
    private enum UIConstants {
        static let collectionWeight: CGFloat = 351
        static let collectionHeight: CGFloat = 96
    }
    
    // MARK: - View's lifecycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Кто играет?"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupNavigationBar()
        initialize()
        setImageCollection()
        
    }
    
    // MARK: - Navigation bar
    
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    // MARK: - Private methods

    // не смогла вынести в отдельный файл
    private func randomImageName() -> String {
        let imageNames = ["2", "3", "4", "5", "6", "7", "8", "9"]
        return imageNames.randomElement() ?? ""
    }
    
    // set image for collection view background
    private func setImageCollection() {
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
    
    @objc private func editButtonPressed(_ sender: UIButton) {
        
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
        
    
    @objc private func deleteButtonPressed(_ sender: UIButton) {
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

// Mark: - Extention initialize

extension TeamViewController {
    
    func initialize() {
            
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(TeamCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            
            view.addSubview(collectionView)
            collectionView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
                
            }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(20)
            make.height.equalTo(60)
        
        }
        
    }
}

// MARK: - Data source

extension TeamViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        teamName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TeamCollectionViewCell else { return UICollectionViewCell() }
        
        let info = teamName[indexPath.item]
        cell.configure(with: info)
        cell.editButton.addTarget(self, action: #selector(editButtonPressed(_:)), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonPressed(_:)), for: .touchUpInside)
        cell.deleteButton.isHidden = indexPath.item < 2
        cell.editButton.isHidden = indexPath.item > 2
        
        cell.layer.cornerRadius = 15
        return cell
    }
    
    
}

// MARK: - Delegate Flow Layout

extension TeamViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIConstants.collectionWeight, height: UIConstants.collectionHeight)
    }
}

// MARK: - Delegate

extension TeamViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item >= 2 {
            teamName.remove(at: indexPath.item)
            collectionView.deleteItems(at: [indexPath])
        }
    }

    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        indexPath.item >= 2
    }
    
}
