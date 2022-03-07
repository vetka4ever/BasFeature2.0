//
//  WatchGamePresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 07.03.2022.
//

import Foundation
class WatchGamePresenter
{
    private var model = WatchGameModel()
    
    
    func getNameOfTeam(teamA: Bool) -> String
    {
        return model.getNameOfTeam(teamA: teamA)
    }
    
    func getCountOfPlayersInTeam(teamA: Bool) -> Int
    {
        return model.getCountOfPlayersInTeam(teamA: teamA)
    }
    
    func getNumOfPlayer(teamA: Bool, id: Int) -> String
    {
        
        return model.getNumOfPlayer(teamA: teamA, id: id)
    }
}
