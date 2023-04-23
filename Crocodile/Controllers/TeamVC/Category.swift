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
    let emoji: String
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
            Category(name: "Food", image: "food1", words: food, emoji: "🍔"),
            Category(name: "Animals", image: "animals", words: animals, emoji: "🐒"),
            Category(name: "People", image: "person", words: people, emoji: "🙋‍♂️"),
            Category(name: "Hobby", image: "hobby", words: hobby, emoji: "🎸"),
            Category(name: "Characters", image: "characters", words: characters, emoji: "🕴"),
            Category(name: "Books", image: "books", words: books, emoji: "📚")
        ]
        
    }
    
    static func getNameTeam() -> [Team] {
        [
            Team(emoji: "🦖", backColor: "tBlue", name: "Динозаврики", score: 0),
            Team(emoji: "👾", backColor: "tPurple", name: "Геймеры", score: 0)
        ]
    }
    
}


