//
//  GamesPresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.12.2021.
//

import UIKit
class ListGamePresenter
{
    private var model = ListGameModel()
    
    func getCountOfGames() -> Int
    {
        model.getCountOfGames()
    }
    
    func getNameAndDateOfGameById(id: Int) -> (String, String)
    {
        return model.getNameAndDateOfGameById(id: id)
    }
    
    func deleteGame(id: Int)
    {
        model.deleteGame(id: id)
    }
    
    func addNameOfWatchedGame(name: String)
    {
        model.addNameOfWatchedGame(name: name)
    }
    
    
}
