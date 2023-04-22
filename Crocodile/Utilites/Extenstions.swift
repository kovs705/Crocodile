//
//  Extenstions.swift
//  Crocodile
//
//  Created by Kovs on 18.04.2023.
//

import UIKit

extension UIButton {
    func blink(enabled: Bool = true, duration: CFTimeInterval = 0.2, stopAfter: CFTimeInterval = 2.0 ) {
        enabled ? (UIView.animate(
            withDuration: duration,
            delay: 0.0,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: { [weak self] in self?.alpha = 0.8 },
            completion: { [weak self] _ in self?.alpha = 1.0 })) : self.layer.removeAllAnimations()
        
        if !stopAfter.isEqual(to: 0.0) && enabled {
            DispatchQueue.main.asyncAfter(deadline: .now() + stopAfter) { [weak self] in
                self?.layer.removeAllAnimations()
            }
        }
    }
}


