//
//  HistoryPresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 14.02.2022.
//

import Foundation
class HistoryPresenter
{
    private var model = HistoryModel()
    
    func getNamesOfTeam() -> (String, String)
    {
        return model.getNamesOfTeams()
    }
    
    func getCountOfAttacksByTeam(nameOfTeam: String) -> Int
    {
        return model.getCountOfAttacksByTeam(team: nameOfTeam)
    }
    
    func getAttacksByTeam(nameOfTeam: String) -> [Attack]
    {
        return model.getAttacksByTeam(team: nameOfTeam)
    }
    
}
