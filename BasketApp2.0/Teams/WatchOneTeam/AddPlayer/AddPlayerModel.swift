//
//  AddPlayerModel.swift
//  BasketApp2.0
//
//  Created by Daniil on 14.12.2021.
//

import UIKit
import RealmSwift
class AddPlayerModel
{
    
    private var realm: Realm
    private var idOfTeam: Int
    private var team: TeamRealm
    
    init()
    {
        self.realm = try! Realm()
        self.idOfTeam = realm.objects(TeamForAddingPlayerRealm.self).first!.accessToId
        self.team = realm.objects(TeamRealm.self).reversed()[idOfTeam]
    }
    
    func addPlayer(player: dataOfPlayer)
    {
        let newPlayer = Player(player: player)
        try! realm.write
        {
            let newTeam = team.accessToTeam
            newTeam?.addPlayerToTeam(newPlayer: newPlayer)
            team.accessToTeam = newTeam
        }
    }
}
