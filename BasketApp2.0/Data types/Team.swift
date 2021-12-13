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
    
    private var allPlayers = [Player]()
    
    enum typeOfInfoOfPlayer
    {
        
        case name
        case number
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
            return allPlayers.count
        }
    }
    
    func getInfoOfPlayer(id: Int, typeOfInfo: typeOfInfoOfPlayer ) -> String
    {
        switch typeOfInfo {
        case .name:
            return allPlayers.reversed()[id].accessToName
        case .number:
            return allPlayers.reversed()[id].accessToNumber
        }
        
        
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

