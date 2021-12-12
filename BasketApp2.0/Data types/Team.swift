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

