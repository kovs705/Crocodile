//
//  Info.swift
//  Crocodile
//
//  Created by mac on 4/20/23.
//

import Foundation

struct Category {
    var name: String
    let image: String
    
    let words: [String]
}

let food = ["картошка", "морковка", "банан", "редиска", "синнабон", "леденец", "мороженое", "торт", "креветки", "стейк"]
let animals = ["свинка", "жираф", "кит", "кошка", "пёс", "крокодил"]
let people = ["джон сина", "трамп", "волшебник", "джеки чан", "программист"]
let hobby = ["кодинг", "игра на басе", "рисование", "компьютерные игры", "плавание", "кэмпинг"]
let characters = ["джон уик", "спанч Боб", "тони старк", "индиана джонс", "супермэн", "наруто"]
let books = ["собачье сердце", "над пропастью во ржи", "шерлок холмс", "101 долматинец", "усов - swift", "ООП в C++"]

extension Category {
    
    static func getCategory() -> [Category] {
        
        [
            Category(name: "Food", image: "food1", words: food),
            Category(name: "Animals", image: "animals", words: animals),
            Category(name: "People", image: "person", words: people),
            Category(name: "Hobby", image: "hobby", words: hobby),
            Category(name: "Characters", image: "characters", words: characters),
            Category(name: "Books", image: "books", words: books)
        ]
        
    }
    
    static func getNameTeam() -> [Category] {
        [
            Category(name: "Хогвардс", image: "5", words: <#[String]#>),
            Category(name: "Звездные войны", image: "8", words: <#[String]#>)
        ]
    }
    
}


