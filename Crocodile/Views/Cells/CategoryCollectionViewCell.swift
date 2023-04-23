//
//  CategoryCollectionViewCell.swift
//  Crocodile
//
//  Created by mac on 4/20/23.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "cell1"
    
    private var cellInfo = Category.getCategory()
    
    //var teamInfo: Info!
    
    // MARK: - Properties
    
    private let nameLable: UILabel = {
       let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.textAlignment = .center
        lable.textColor = .black
        return lable
    }()
    
    private let categoryImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        //imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = .systemGray
        imageView.isHidden = true
        return imageView
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public method
    
    func configure(with teamName: Category, isSelected: Bool) {
        nameLable.text = "\(teamName.name) + 1" // + 1 убрать как в предыдущем варианте
        categoryImage.image = UIImage(named: teamName.image)
        checkmarkImageView.isHidden = !isSelected
        
    }
    
    override var isSelected: Bool {
        didSet {
            checkmarkImageView.image = isSelected ? UIImage(named: "checkmark_selected") : UIImage(named: "checkmark_unselected")
        }
    }
    
    
    // MARK: - Private method
    
    private func setupView() {
        backgroundColor = .white
        
        contentView.addSubview(categoryImage)
        categoryImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        contentView.addSubview(nameLable)
        nameLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            
        }
        
        contentView.addSubview(checkmarkImageView)
        checkmarkImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
    }
    
    
}

