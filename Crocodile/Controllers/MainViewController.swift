//
//  ViewController.swift
//  Crocodile
//
//  Created by Kovs on 17.04.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    let backgroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "backgroundImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
}

