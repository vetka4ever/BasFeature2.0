//
//  GamePresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 16.12.2021.
//

class GamePresenter
{
    private var model = GameModel()
    
    func getCountOfPlayers(teamA: Bool) -> Int
    {
        return model.getCountOfPlayers(teamA: teamA)
    }
    
    func getNumOfPlayer(teamA: Bool, id: Int) -> String
    {
        return model.getNumOfPlayer(teamA: teamA, id: id)
    }
    
    func getNameOfTeam(teamA:Bool) -> String
    {
        model.getNameOfTeam(teamA: teamA)
    }
}
