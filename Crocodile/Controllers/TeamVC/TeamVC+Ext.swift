//
//  TeamVC+Ext.swift
//  Crocodile
//
//  Created by Kovs on 22.04.2023.
//

import UIKit

extension TeamVC {
    
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


// MARK: - ViewDataSource
extension TeamVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        teamObj.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TeamCollectionViewCell else { return UICollectionViewCell() }
        
        let info = teamObj[indexPath.item]
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
extension TeamVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Resources.UIConstants.collectionWeight, height: Resources.UIConstants.collectionHeight)
    }
}

// MARK: - Delegate
extension TeamVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item >= 2 {
            teamObj.remove(at: indexPath.item)
            collectionView.deleteItems(at: [indexPath])
        }
    }

    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        indexPath.item >= 2
    }
    
}


