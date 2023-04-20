//
//  Info.swift
//  Crocodile
//
//  Created by mac on 4/20/23.
//

import Foundation

struct Info {
    let name: String
    let image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
/*
static func randomImage() -> String {
    let randomIndex = Int.random(in: 1...7)
    return "team \(randomIndex)"
  }
   */
}
