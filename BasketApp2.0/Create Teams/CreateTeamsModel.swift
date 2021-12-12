//
//  CreateTeamsModel.swift
//  BasketApp2.0
//
//  Created by Daniil on 12.12.2021.
//

import UIKit
import RealmSwift

class CreateTeamsModel
{
    private var realm = try! Realm()
    
    func createTeam(nameOfTeam: String)
    {
        try! realm.write
        {
            let team = Team()
            team.accessToName = nameOfTeam
            let object = TeamRealm()
            object.accessToTeam = team
            realm.add(object)
        }
    }
    
    
    
}
