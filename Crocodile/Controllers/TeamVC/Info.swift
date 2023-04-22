//
//  Info.swift
//  Crocodile
//
//  Created by mac on 4/20/23.
//

import Foundation

struct Info {
    var name: String
    let image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }

}

extension Info {
    
    static func getCategory() -> [Info] {
        
        [
            Info(name: "Food", image: "food1"),
            Info(name: "Animals", image: "animals"),
            Info(name: "People", image: "person"),
            Info(name: "Hobby", image: "hobby"),
            Info(name: "Characters", image: "characters"),
            Info(name: "Books", image: "books")
        ]
        
    }
    
    static func getNameTeam() -> [Info] {
        [
        Info(name: "Хогвордс", image: "5"),
        Info(name: "Звездные войны", image: "8")
        ]
    }
    
}


