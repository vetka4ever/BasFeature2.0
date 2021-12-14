//
//  Teams.swift
//  BasketApp2.0
//
//  Created by Daniil on 12.12.2021.
//

import Foundation
import RealmSwift

class Team: Codable
{
    private var name = ""
    
    private var players = [Player]()
    
    enum typeOfInfoOfPlayer
    {
        case name
        case number
        case dateOfBirth
        case height
        case weight
    }
    
    var accessToName: String
    {
        get
        {
            return self.name
        }
        set
        {
            self.name = newValue
        }
    }
    
    var getNumOfPlayers: Int
    {
        get
        {
            return players.count
        }
    }
    
    func getInfoAboutPlayers(id: Int, typeOfInfo: typeOfInfoOfPlayer ) -> String
    {
        switch typeOfInfo
        {
        case .name:
            return players.reversed()[id].name
        case .number:
            return players.reversed()[id].number
        case .dateOfBirth:
            return players.reversed()[id].dateOfBirth
        case .height:
            return players.reversed()[id].height
        case .weight:
            return players.reversed()[id].weight
        }
    }
    
    func addPlayerToTeam(newPlayer: Player)
    {
        self.players.append(newPlayer)
    }
    
}

class TeamRealm: Object
{
    @objc private dynamic var classData: Data? = nil
    var accessToTeam: Team?
    {
        get
        {
            if let newValue = classData
            {
                return try? JSONDecoder().decode(Team.self, from: newValue)
            }
            return nil
        }
        set
        {
            classData =  try? JSONEncoder().encode(newValue)
        }
    }
}

class TeamForAddingPlayerRealm: Object
{
    @objc private dynamic var id: Int = 0
    var accessToId: Int
    {
        get
        {
            return id
        }
        set
        {
            self.id = newValue
        }
    }
}

