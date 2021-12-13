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
    var reversedArrayOfTeams = [TeamRealm]()
    
    func updateReversedArrayOfTeams()
    {
        reversedArrayOfTeams = teams.reversed()
                
        /// IT WAS TEST
//        for item in teams
//        {
//            try! (try! Realm()).write
//            {
//                var object = Team()
//                object = item.accessToTeam!
//                object.accessToName = "EMPTY SPACE"
//                item.accessToTeam = object
//
//            }
//        }
//
//        print("-------------------TEAMS-------------------")
//        for item in teams
//        {
//            print(item.accessToTeam?.accessToName)
//        }
//        print("-------------------REVERSED TEAMS-------------------")
//        for item in reversedArrayOfTeams
//        {
//            print(item.accessToTeam?.accessToName)
//        }
        
    }
    
    func getNameOfTeamWithSpecialId(id: Int) -> String
    {
        
        return reversedArrayOfTeams[id].accessToTeam!.accessToName
    }
    
    func getCountOfTeams() -> Int
    {
        return reversedArrayOfTeams.count
    }
    
    func saveTeamForAddingPLayer(id: Int)
    {
        let realm = try! Realm()
        try! realm.write
        {
            let object = TeamForAddingPlayerRealm()
            object.accessToId = id
            realm.add(object)
        }
    }
}
