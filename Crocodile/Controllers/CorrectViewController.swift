import Foundation
import UIKit
class CorrectViewController: UIViewController {
    
    let backgroundImage = UIImageView(image: UIImage(named: Resources.Image.backgroundImage))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
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
    
}
