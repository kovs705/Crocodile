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
        
        // MARK: - Проверить это.
        // Получать данные из UserDefaults по командам. Ключ "teams"
        // суммировать по итогу выбранные категории в один большой array, из которого затем будут использоваться рандомно объекты
        // array из заданий а-ля "объясни это жестами" и т.д
        // три раза пройтись по командам, что в итоге даст каждой команде сыграть в сумме по 3 раза
        getTeams()
        
    }
    
}
