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
        
        setupBackgroundImage()
        placeSV()
        placeStackView()
        
    }
}
