//
//  ViewController.swift
//  Crocodile
//
//  Created by Kovs on 17.04.2023.
//

import UIKit
import SnapKit

class MainViewController: MainVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundImage()
        setupCrocodileImage()
        
        setupStartGameButton()
        setupRulesGameButton()
        setupResultsButton()
        setupStackView()
        
        setupGrassImage()
        
    }

    
}
