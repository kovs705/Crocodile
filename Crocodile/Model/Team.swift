//
//  Team.swift
//  Crocodile
//
//  Created by Kovs on 20.04.2023.
//

import Foundation
import UIKit

// MARK: - emojies, names, colors
let emojies: Set = ["😈", "💀", "👨‍💻", "😼", "😎", "🐊", "🦖", "👾", "👻", "🥷"]
let backColor: Set = ["tGray", "tBlue", "tLime", "tPink", "tPurple"]
let names: Set = ["Занозы", "Крутыши", "Котаны", "Геймеры", "Ниндзя", "Злодеи", "Кодеры", "Ящерки", "Призраки"]


struct Team: Codable, Hashable {
    let emoji: String
    let backColor: String
    
    var name: String
    var score: Int
}


enum teamActions {
    case add
    case remove
    
    case plus
    case minus
}

enum tError: String, Error {
    case smthWrong = "Something went wrong"
}

enum TeamManager {
    static public let shared = TeamManager.self
    static private let defautls = UserDefaults.standard
    
    enum Keys {
        static let teamsKey = "teams"
    }
    
    
    // MARK: - update
    static func updateWith(team: Team, action: teamActions, completed: @escaping (tError?) -> Void) {
        getTeams { result in
            switch result {
            case .success(var teamsArray):
                
                switch action {
                case .add:
                    teamsArray.append(team)
                    
                case .remove:
                    teamsArray.removeAll { $0.name == team.name && $0.emoji == team.emoji }
                    
                case .plus:
                    guard teamsArray.contains(where: { $0.name == team.name && $0.emoji == team.emoji }) else {
                        return completed(.smthWrong)
                    }
                    
                    teamsArray = teamsArray.map { t in
                        if t.name == team.name && t.emoji == team.emoji {
                            return Team(emoji: t.emoji, backColor: t.backColor, name: t.name, score: t.score+1)
                        } else { return t }
                    }
                    
                case .minus:
                    guard teamsArray.contains(where: { $0.name == team.name && $0.emoji == team.emoji }) else {
                        return completed(.smthWrong)
                    }
                    
                    teamsArray = teamsArray.map { t in
                        if t.name == team.name && t.emoji == team.emoji {
                            return Team(emoji: t.emoji, backColor: t.backColor, name: t.name, score: t.score-1)
                        } else { return t }
                    }
                }
                
                completed(save(teams: teamsArray))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    // MARK: - getTeams
    static func getTeams(completed: @escaping (Result<[Team], tError>) -> Void) {
        guard let teamsData = defautls.object(forKey: Keys.teamsKey) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let teams = try decoder.decode([Team].self, from: teamsData)
            completed(.success(teams))
        } catch {
            completed(.failure(.smthWrong))
        }
    }
    
    
    // MARK: - Save
    static func save(teams: [Team]) -> tError? {
        do {
            let encoder = JSONEncoder()
            let encodedTeams = try encoder.encode(teams)
            defautls.set(encodedTeams, forKey: Keys.teamsKey)
            print("saved")
            return nil
        } catch {
            return .smthWrong
        }
    }
    
}


