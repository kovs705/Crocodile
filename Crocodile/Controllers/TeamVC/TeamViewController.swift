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
    private var teamInfo: [Info] = []
    
    // MARK: - Private properties
    
    lazy var mainImageView: UIImageView = {
       var imageView = UIImageView()
        imageView = UIImageView(frame: self.view.bounds)
        imageView.image = backgroundImage
        imageView.contentMode = .scaleAspectFill
        imageView.center = view.center
        return imageView
    }()
    
    private var collectionView: UICollectionView = {
        
       let layot = UICollectionViewFlowLayout()
        layot.scrollDirection = .vertical
        layot.minimumInteritemSpacing = 16
        layot.minimumLineSpacing = 16
        layot.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layot.itemSize = CGSize(width: 351, height: 96)
        
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layot)
        collectionV.backgroundColor = .clear
        collectionV.backgroundColor = #colorLiteral(red: 0.7847468257, green: 0.9781709313, blue: 0.6624839902, alpha: 1)
        
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
        navigationItem.rightBarButtonItem = barButton()

        initialize()
        
    }
    
    // MARK: - Private methods
    
    
    private func randomImageName() -> String {
        let imageNames = ["2", "3", "4", "5", "6", "7"]
        return imageNames.randomElement() ?? ""
    }
    
    
    // MARK: - Add Button in tab bar

    func barButton() -> UIBarButtonItem {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
       return addButton
    }

    
    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "Add Team", message: "Enter team name", preferredStyle: .alert)
        
        alertController.addTextField {
            textField in textField.placeholder = "Team name"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) {
            [weak self] _ in
            if let teamName = alertController.textFields?.first?.text {
                let randomImageName = self?.randomImageName()
                let newTeam = Info(name: teamName, image: randomImageName ?? "")
                self?.teamInfo.append(newTeam)
                self?.collectionView.reloadData()
            }
                                                                    
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    // MARK: - Button to the next scree "Category"
    
    @objc func buttonPressed() {
        
        let categoryVC = CategoryViewController()
        navigationController?.pushViewController(categoryVC, animated: true)
        
    }

}

extension TeamViewController {
    
    func initialize() {
        
        view.addSubview(mainImageView)
            
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(TeamCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            
            view.addSubview(collectionView)
            collectionView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
                make.leading.trailing.equalToSuperview()//.inset(30)
                make.bottom.equalToSuperview()//.inset(100)
                
            }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(20)
            make.height.equalTo(60)
        
        }
        
    }
}

extension TeamViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        teamInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TeamCollectionViewCell
        cell.configure(with: teamInfo[indexPath.item])
        cell.layer.cornerRadius = 15
        
        return cell
    }
    
    
}

extension TeamViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIConstants.collectionWeight, height: UIConstants.collectionHeight)
    }
}


