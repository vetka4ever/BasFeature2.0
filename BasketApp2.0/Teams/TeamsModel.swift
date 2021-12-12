//
//  TeamsModel.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.12.2021.
//

import UIKit
import RealmSwift
class TeamsModel
{
    private var teams: Results<TeamRealm> = (try! Realm()).objects(TeamRealm.self)

    
    func getNameOfTeamWithSpecialId(id: Int) -> String
    {
        let reversedTeams: [TeamRealm] = teams.reversed()
        return reversedTeams[id].accessToTeam!.accessToName
    }
    
    func getCountOfTeams() -> Int
    {
        return teams.count
    }
}
