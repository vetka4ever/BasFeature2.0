//
//  GamePresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 16.12.2021.
//

import UIKit

class GamePresenter
{
    enum Mode: Int
    {
        case input = 0
        case all
        case scored
        case will
        case end
    }
    private var view = UIViewController()
    private var model = GameModel()
    private var teamA: Bool? = nil
    private var currentPlayer: String = ""
    private var currentMode: Mode = .input
    private var currentTime: Int = 1
    private var currentZone: Int = 0
    func setTime(time: Int)
    {
        self.currentTime = time
    }
    
    func setPlayer(teamA: Bool, player: String)
    {
        self.teamA = teamA
        self.currentPlayer = player
    }
    
    func setMode(mode: Int)
    {
        self.currentMode = Mode.init(rawValue: mode)!
    }
    
    func setView(view: GameView)
    {
        self.view = view
    }
    
    func setNumOfZone(zone: Int)
    {
        self.currentZone = zone
        print(currentZone)
    }
    
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
