//
//  CategoryVC.swift
//  Crocodile
//
//  Created by Kovs on 22.04.2023.
//

import UIKit

class CategoryVC: UIViewController {
    
    
    let backgroundImage = UIImage(named: "backgroundImage")
    var infoCell = Info.getCategory()
    var selectedCellIndex: [Int] = []
    
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
        let categoryVC = TeamViewController()
        navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    
    func setImageCollection() {
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        collectionView.backgroundView = backgroundImageView
    }
    
    
    
}
