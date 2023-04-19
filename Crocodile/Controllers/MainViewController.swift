//
//  ViewController.swift
//  Crocodile
//
//  Created by Kovs on 17.04.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    let backgroundImage = UIImageView(image: UIImage(named: "backgroundImage"))

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
    }

    func setupBackground() {
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
        make.top.equalToSuperview()
        make.bottom.equalToSuperview()
        make.left.equalToSuperview()
        make.right.equalToSuperview()
        }
    }
}
