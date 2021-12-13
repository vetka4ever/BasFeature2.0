//
//  WatchOneTeamModel.swift
//  BasketApp2.0
//
//  Created by Daniil on 13.12.2021.
//

import UIKit
import RealmSwift
class WatchOneTeamModel
{
    private var realm: Realm
    private var id: Int
    private var team: TeamRealm
    
    init()
    {
        realm = try! Realm()
        id = realm.objects(TeamForAddingPlayerRealm.self).first!.accessToId
        team = realm.objects(TeamRealm.self).reversed()[id]
    }
    
    func getNumOfPlayers() -> Int
    {
        return team.accessToTeam!.getNumOfPlayers
    }
    
    func getNameOfPlayer(id: Int) -> String
    {
        return team.accessToTeam!.getInfoOfPlayer(id: id, typeOfInfo: .name)
    }
    
    func getNumberOfPlayer(id: Int) -> String
    {
        return team.accessToTeam!.getInfoOfPlayer(id: id, typeOfInfo: .number)
    }
    
    func getNameOfTeam() -> String
    {
        return team.accessToTeam!.accessToName
    }
}
