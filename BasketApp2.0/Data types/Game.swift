//
//  Game.swift
//  BasketApp2.0
//
//  Created by Daniil on 15.12.2021.
//

import RealmSwift
import Foundation
class CurrentGame: Codable
{
    private var name: String
    private let teamA: Team // coach's team
    private let teamB: Team // enemy's team
    
    init(teamA: Team, teamB: Team, name: String)
    {
        self.teamA = teamA
        self.teamB = teamB
        self.name = name
    }
    
    var accessToTeamA: Team
    {
        get
        {
            return teamA
        }
    }
    
    var accessToTeamB: Team
    {
        get
        {
            return teamB
        }
    }
    
    var accessToName: String
    {
        get
        {
            return name
        }
    }
}

class CurrentGameRealm: Object
{
    @objc private dynamic var classData: Data? = nil
    
    var accessToGame: CurrentGame?
    {
        get
        {
            if let gameData = classData
            {
                return try? JSONDecoder().decode(CurrentGame.self, from: gameData)
            }
            else
            {
                return nil
            }
        }
        set
        {
            classData = try? JSONEncoder().encode(newValue)
        }
    }
}

class DoneGame: CurrentGame
{
    private var attacks = [Attack]()
    private var date = ""
    
    init(game: CurrentGame, attacks: [Attack], date: String)
    {
        super.init(teamA: game.accessToTeamA, teamB: game.accessToTeamB, name: game.accessToName)
        self.attacks = attacks
        self.date = date
    }
    
    func getDate() -> String
    {
        return self.date
    }
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}

class DoneGameRealm: Object
{
    @objc private dynamic var classData: Data? = nil
    
    var accessToGame: DoneGame?
    {
        get
        {
            if let gameData = classData
            {
                return try? JSONDecoder().decode(DoneGame.self, from: gameData)
            }
            else
            {
                return nil
            }
        }
        set
        {
            classData = try? JSONEncoder().encode(newValue)
        }
    }
}
