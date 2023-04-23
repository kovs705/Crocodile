//
//  CategoryVC+Ext.swift
//  Crocodile
//
//  Created by Kovs on 22.04.2023.
//

import UIKit


// MARK: - Data Source

extension CategoryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        infoCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.cornerRadius = 15
        let info = infoCell[indexPath.item]
        cell.configure(with: info)
        cell.isChecked = selectedCellIndex.contains(indexPath.item)
        
        
        return cell
    }
    
}

// MARK: - DelegateFlowLayout

extension CategoryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Resources.UIConstants.collectionWeight, height: Resources.UIConstants.collectionHeight)
    }
}

// MARK: - Delegate

extension CategoryVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
            cell.isSelected = !cell.isSelected
            if selectedCellIndex.contains(indexPath.item) {
                selectedCellIndex.removeAll { $0 == indexPath.item}
            } else {
                selectedCellIndex.append(indexPath.item)
            }
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
}
