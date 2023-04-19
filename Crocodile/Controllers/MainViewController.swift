//
//  ViewController.swift
//  Crocodile
//
//  Created by Kovs on 17.04.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    let backgroundImage = UIImageView(image: UIImage(named: Resources.Image.backgroundImage))
    let crocodileImage = UIImageView(image: UIImage(named: Resources.Image.crocodileImage))

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundImage()
        setupCrocodileImage()
        
    }

    func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
        make.top.equalToSuperview()
        make.bottom.equalToSuperview()
        make.left.equalToSuperview()
        make.right.equalToSuperview()
        }
    }

    func setupCrocodileImage() {
        view.addSubview(crocodileImage)
        crocodileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(172)
            make.left.equalToSuperview().offset(54)
            make.right.equalToSuperview().offset(-54)
        }
    }
}
