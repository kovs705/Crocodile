//
//  GameResultViewController.swift
//  Crocodile
//
//  Created by Kovs on 17.04.2023.
//

import UIKit


class GameResultsViewController: GameResults {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Кто играет?"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem?.isEnabled = false
        
        
        
        getTeams()
        setupBackgroundImage()
        placeSV()
        placeStackView()
        
        
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(20)
            make.height.equalTo(60)
        
        }

    }
}
