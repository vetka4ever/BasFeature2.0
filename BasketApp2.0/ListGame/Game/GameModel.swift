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
    private var attacks = [Attack]()
    
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
    
    func inputAttack(teamA: Bool, numOfPlayer: String, result: Bool, time: Int, zone: Int)
    {
        let shot = Attack(time: time, player: numOfPlayer, zone: zone, result: result, teamA: teamA)
        self.attacks.append(shot)
    }
    
    func getAllScore(teamA: Bool, player: String) -> [String]
    {
        var score: [String] = Array.init(repeating: "", count: 14)
        //(win,all in current zone)
        var scoreDecimal: [(Int,Int)] = Array.init(repeating: (0,0), count: 14)
        for item in attacks where item.accessToTeamA == teamA && item.accessToPlayer == player
        {
            scoreDecimal[item.accessToZone - 1].1 += 1
            if item.accessToResult {scoreDecimal[item.accessToZone - 1].0 += 1}
        }
        var win: Int = 0
        var all: Int = 0
        var percent: Double = 0
        
        for i in 0...score.count-1
        {
            win = scoreDecimal[i].0
            all = scoreDecimal[i].1
            percent = (all == 0) ? (0) : (Double(win)/Double(all) * 100)
            score[i] = "\(win)/\(all)\n\(String(format: "%.2f", percent))%"
        }
        return score
    }
    
    func getScoredScore(teamA: Bool, player: String) -> [String]
    {
        var score: [String] = Array.init(repeating: "", count: 14)
        //(win,all in all game)
        var scoreDecimal: [(Int)] = Array.init(repeating: 0, count: 14)
        
        var all: Int = 0
        var percent: Double = 0
        
        for item in attacks
        {
            if item.accessToResult && item.accessToTeamA == teamA { all += 1 }
            if item.accessToTeamA == teamA && item.accessToPlayer == player && item.accessToResult { scoreDecimal[item.accessToZone-1] += 1 }
        }
        
        for i in 0...score.count-1
        {
            percent = (scoreDecimal[i] == 0) ? (0) : (Double(scoreDecimal[i]) / Double(all) * 100)
            score[i] = "\(scoreDecimal[i])/\(all)\n\(String(format: "%.2f", percent))%"
        }
        
        return score
    }

    func getShotScore(teamA: Bool, player: String) -> [String]
    {
        return [String]()
    }
    
    func saveGame()
    {
        
    }
}
