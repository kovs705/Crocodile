//
//  TeamViewController.swift
//  Crocodile
//
//  Created by mac on 4/20/23.
//

import UIKit
import SnapKit

class TeamViewController: TeamVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Кто играет?"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupNavigationBar()
        initialize()
        setImageCollection()
        
    }
    
}
