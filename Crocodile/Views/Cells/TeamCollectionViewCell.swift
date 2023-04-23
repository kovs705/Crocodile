//
//  TeamCollectionViewCell.swift
//  Crocodile
//
//  Created by mac on 4/20/23.
//

import UIKit
import SnapKit

class TeamCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"
    let imageButtonDelete = UIImage(systemName: "xmark.app")
    let imageButtonEdit = UIImage(systemName: "pencil")
    var onDeleteButton: (() -> Void)?
    
    var teamInfo: Category!
    
    // MARK: - Properties
    
    let nameLable: UILabel = {
       let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.textAlignment = .center
        lable.textColor = .black
        return lable
    }()
    
    let teamImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(imageButtonDelete, for: .normal)
        button.tintColor = .red
        return button
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(imageButtonEdit, for: .normal)
        button.tintColor = .green
        return button
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    func configure(with team: Team) {
        print(team.name)
        print(team.backColor)
        print(team.emoji)
        print(team.score)
    }
    
    // MARK: - Private method
    
    private func setupView() {
        backgroundColor = .white
        
        contentView.addSubview(teamImageView)
        teamImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        contentView.addSubview(nameLable)
        nameLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            
        }
        
        contentView.addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(12)
            make.width.height.equalTo(24)
        }
        
        contentView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(8)
            make.width.height.equalTo(24)
        }
        
    }
    
}

