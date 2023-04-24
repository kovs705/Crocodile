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
    let back: String
    let index: Int
}

let food = ["картошка", "морковка", "банан", "редиска", "синнабон", "леденец", "мороженое", "торт", "креветки", "стейк", "яблоко", "манго", "авокадо", "кумкват", "кабачок", "кукуруза", "огурец", "пюре", "котлетки", "макарошки"]
let animals = ["свинка", "жираф", "кит", "кошка", "пёс", "крокодил", "зебра", "лев", "арангутанг", "шимпанзе", "вумбат", "енот", "муравьед", "акула", "морской котик", "медведь", "олень", "гепард", "носорог", "лошадь"]
let people = ["джон сина", "трамп", "волшебник", "джеки чан", "программист", "женщина", "мужчина"]
let hobby = ["кодинг", "игра на басе", "рисование", "компьютерные игры", "плавание", "кэмпинг", "шитье", "конный спорт", "лыжный спорт", "бобслей", "кёрлинг", "ролики", "марафоны", "колекционирование"]
let characters = ["джон уик", "спанч Боб", "тони старк", "индиана джонс", "супермэн", "наруто", "сабзиро", "веном", "человек паук", "тор", "грут", "Нео", "хоббит", "гарри поттер", "майло (фильм маска)"]
let books = ["собачье сердце", "над пропастью во ржи", "шерлок холмс", "101 долматинец", "усов - swift", "ООП в C++", "хроники нарнии", "камасутра", "стихи тиля линдеманна", "три мушкетера"]

extension Category {
    
    static func getCategory() -> [Category] {
        
        [
            Category(name: "Food", image: "food1", words: food, emoji: "🍔", back: "tLime", index: 0),
            Category(name: "Animals", image: "animals", words: animals, emoji: "🐒", back: "tBlue", index: 1),
            Category(name: "People", image: "person", words: people, emoji: "🙋‍♂️", back: "tPink", index: 2),
            Category(name: "Hobby", image: "hobby", words: hobby, emoji: "🎸", back: "tGray", index: 3),
            Category(name: "Characters", image: "characters", words: characters, emoji: "🕴", back: "tPurple", index: 4),
            Category(name: "Books", image: "books", words: books, emoji: "📚", back: "tBlue", index: 5)
        ]
        
    }
    
    static func getActions() -> [String] {
        return [
            "Объясни с помощью слов",
            "Объясни с помощью жестов",
            "Объясни с помощью рисунка",
            "Объясняй со злостью",
            "Объясняй с помощью мимики",
            "Объясняй вульгарно",
            "Объясняй сексуально"
        ]
    }
    
    static func getBaseTeams() -> [Team] {
        [
            Team(emoji: "🦖", backColor: "tBlue", name: "Динозаврики", score: 0),
            Team(emoji: "👾", backColor: "tPurple", name: "Геймеры", score: 0)
        ]
    }
    
}


