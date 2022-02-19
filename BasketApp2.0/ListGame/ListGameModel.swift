//
//  GamesModel.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.12.2021.
//

import UIKit
import RealmSwift
class ListGameModel
{
    private var realm: Realm
    private var games: [DoneGameRealm]
    init()
    {
        self.realm = try! Realm()
        self.games = realm.objects(DoneGameRealm.self).reversed()
    }
    func getCountOfGames() -> Int
    {
//        return games.count
        return realm.objects(DoneGameRealm.self).reversed().count
    }
    
    func getNameAndDateOfGameById(id: Int) -> (String, String) // (name, date)
    {
        let name = realm.objects(DoneGameRealm.self).reversed()[id].accessToGame!.accessToName
        let date = realm.objects(DoneGameRealm.self).reversed()[id].accessToGame!.accessToDate
        
        return (name,date)
    }
    func deleteGame(id: Int)
    {
        try! realm.write
        {
            realm.delete(games[id])
        }
    }
}

