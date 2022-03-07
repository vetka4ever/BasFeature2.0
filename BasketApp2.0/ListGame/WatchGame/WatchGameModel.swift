//
//  WatchGameModel.swift
//  BasketApp2.0
//
//  Created by Daniil on 07.03.2022.
//

import RealmSwift
class WatchGameModel
{
    private var realm: Realm
    private var game = DoneGame()
    
    init()
    {
        self.realm = try! Realm()
        findGame()
        print(game.accessToName)
    }
    
    private func findGame()
    {
        let name = realm.objects(NameOfGameForWatchingRealm.self).first!.accessToName
        for item in realm.objects(DoneGameRealm.self)
        {
            if item.accessToGame!.accessToName == name
            {
                self.game = item.accessToGame!
                break
            }
        }
    }
    
    func getNameOfTeam(teamA: Bool) -> String
    {
        return teamA ? (game.accessToTeamA.accessToName) : (game.accessToTeamB.accessToName)
    }
    
    func getCountOfPlayersInTeam(teamA: Bool) -> Int
    {
        return teamA ? (game.accessToTeamA.getNumOfPlayers) : (game.accessToTeamB.getNumOfPlayers)
    }
    
    func getNumOfPlayer(teamA: Bool, id: Int) -> String
    {
        
        return teamA ? (game.accessToTeamA.getInfoAboutPlayers(id: id, typeOfInfo: .number)) : (game.accessToTeamB.getInfoAboutPlayers(id: id, typeOfInfo: .number))
    }
    
}

