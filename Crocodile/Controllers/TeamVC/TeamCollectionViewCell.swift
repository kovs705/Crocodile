//
//  TeamCollectionViewCell.swift
//  Crocodile
//
//  Created by mac on 4/20/23.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"
    
    var teamInfo: Info!
    
    // MARK: - Properties
    
    private let nameLable: UILabel = {
       let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.textAlignment = .center
        lable.textColor = .black
        return lable
    }()
    
    private let teamImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
    
    func configure(with teamName: Info) {
        nameLable.text = teamName.name
        teamImageView.image = UIImage(named: teamName.image)
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
        
    }
    
    
}
