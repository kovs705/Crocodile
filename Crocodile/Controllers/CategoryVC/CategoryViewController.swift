//
//  CategoryViewController.swift
//  Crocodile
//
//  Created by Kovs on 17.04.2023.
//

import UIKit
import SnapKit

class CategoryViewController: CategoryVC {
    
    // MARK: - View's lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Категории"
        navigationController?.navigationBar.prefersLargeTitles = true

        initialize()
        setImageCollection()
        getTeams()
    }
    
}

// Mark: - Evtention constraints

extension CategoryViewController {
    
    func initialize() {
            
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "cell1")
            
            view.addSubview(collectionView)
            collectionView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
                
            }
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(20)
            make.height.equalTo(60)
        
        }
        
    }
}

