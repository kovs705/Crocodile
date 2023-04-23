//
//  CategoryViewController.swift
//  Crocodile
//
//  Created by Kovs on 17.04.2023.
//

import UIKit
import SnapKit

class CategoryViewController: UIViewController {
    
    // MARK: - Properties
    
    let backgroundImage = UIImage(named: "backgroundImage")
    private var infoCell = Info.getCategory()
    var selectedCellIndex: [Int] = []
    
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
        button.setTitle("Начать игру", for: .normal)
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
        title = "Категории"
        navigationController?.navigationBar.prefersLargeTitles = true

        initialize()
        setImageCollection()
        
    }
    
    // Mark: Methods
    
    @objc func buttonPressed() {
        let categoryVC = TeamViewController()
        navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    // MARK: - Private methods
    
    private func setImageCollection() {
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        collectionView.backgroundView = backgroundImageView
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
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(20)
            make.height.equalTo(60)
        
        }
        
    }
}

// Mark: - Data Source

extension CategoryViewController: UICollectionViewDataSource {
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

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIConstants.collectionWeight, height: UIConstants.collectionHeight)
    }
}

// MARK: - Delegate

extension CategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedCellIndex.contains(indexPath.item) {
            selectedCellIndex.removeAll { $0 == indexPath.item}
        } else {
            selectedCellIndex.append(indexPath.item)
        }
        collectionView.reloadItems(at: [indexPath])
    }
}
    

