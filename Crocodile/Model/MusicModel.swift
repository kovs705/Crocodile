//
//  MusicModel.swift
//  Crocodile
//
//  Created by Админ on 18.04.2023.
//

import Foundation
import AVFoundation

class MusicModel {
    var player: AVAudioPlayer?
    
    func playSound(nameOfMusic: String) {
        
        DispatchQueue.global().async {
            guard let path = Bundle.main.path(forResource: nameOfMusic, ofType: "wav") else { return }
            let url = URL(fileURLWithPath: path)

            do {
                self.player = try AVAudioPlayer(contentsOf: url)
                self.player?.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
