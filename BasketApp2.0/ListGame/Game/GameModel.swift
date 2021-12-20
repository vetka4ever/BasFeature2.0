//
//  GameModel.swift
//  BasketApp2.0
//
//  Created by Daniil on 16.12.2021.
//

import RealmSwift
class GameModel
{
    private let realm: Realm
    private var game: CurrentGame
    private var attack = [Attack]()
    
    init()
    {
        self.realm = try! Realm()
        self.game = realm.objects(CurrentGameRealm.self).first!.accessToGame!
    }
    
    func getCountOfPlayers(teamA: Bool) -> Int
    {
        return (teamA ? (self.game.accessToTeamA.getNumOfPlayers) : (self.game.accessToTeamB.getNumOfPlayers) )
    }
    
    func getNumOfPlayer(teamA: Bool, id: Int) -> String
    {
        return (teamA ? (self.game.accessToTeamA.getInfoAboutPlayers(id: id, typeOfInfo: .number)) : (self.game.accessToTeamB.getInfoAboutPlayers(id: id, typeOfInfo: .number)))
    }
    
    func getNameOfTeam(teamA:Bool) -> String
    {
        return teamA ? (game.accessToTeamA.accessToName) :(game.accessToTeamB.accessToName)
    }
}
