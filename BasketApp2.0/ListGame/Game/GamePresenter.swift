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
        case shot
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
        if self.teamA == teamA && self.currentPlayer == player
        {
            self.teamA = nil
            self.currentPlayer = ""
            if let newView = view as? GameView
            {
                newView.reloadTableView(teamA: teamA)
            }
        }
        else
        {
        self.teamA = teamA
        self.currentPlayer = player
        }
        doingByMode()
    }
    
    
    func setMode(mode: Int)
    {
        self.currentMode = Mode.init(rawValue: mode)!
        if mode != Mode.input.rawValue
        {
            self.currentZone = 0
        }
        if let newView = view as? GameView
        {
            newView.changeVisibleElementsOfField(turnOn: self.currentMode != .input)
        }
        doingByMode()
    }
    
    private func doingByMode()
    {
        switch (currentMode)
        {
        case .input:
            getInputScore()
        case .all:
            getAllScore()
        case .scored:
            getScoredScore()
        case .shot:
            getShotScore()
        case .end:
            endGame()
        }
    }
    
    private func getInputScore()
    {
        if currentZone != 0 && self.currentPlayer != ""
        {print("Inputing...")}
    }
    
    private func getAllScore()
    {
        
    }
    
    private func getScoredScore()
    {
        
    }
    
    private func getShotScore()
    {
        
    }
    
    private func endGame()
    {
        
    }
    
    func setView(view: GameView)
    {
        self.view = view
    }
    
    func setNumOfZone(zone: Int)
    {
        self.currentZone = zone
        doingByMode()
        
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
