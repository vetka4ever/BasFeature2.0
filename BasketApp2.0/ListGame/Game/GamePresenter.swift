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
    private var currentTeamA: Bool? = nil
    private var currentPlayer: String = ""
    private var currentMode: Mode = .input
    private var currentTime: Int = 1
    private var currentZone: Int = 0
    
    //MARK: FUNCS SETTING VALUES
    func setView(view: GameView)
    {
        self.view = view
    }
    
    func setNumOfZone(zone: Int)
    {
        self.currentZone = zone
        doingByMode()
    }
    
    func setTime(time: Int)
    {
        self.currentTime = time
    }
    
    func setPlayer(teamA: Bool, player: String)
    {
        if self.currentTeamA == teamA && self.currentPlayer == player
        {
            self.currentTeamA = nil
            self.currentPlayer = ""
            if let newView = view as? GameView
            {
                newView.reloadTableView(teamA: teamA)
            }
        }
        else
        {
            self.currentTeamA = teamA
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
            inputScore()
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
    
    // MARK: DOING BY MODE
    private func inputScore()
    {
        if currentZone != 0 && self.currentPlayer != ""
        {
            view.present(getAlert(), animated: true, completion: nil)
        }
        
    }
    
    private func getAlert() -> UIAlertController
    {
        let alert = UIAlertController(title: "Input", message: "Enter result of shot", preferredStyle: .alert)
        let win = UIAlertAction(title: "Win", style: .default) {  [self] UIAlertAction in
            model.inputAttack(teamA: currentTeamA!, numOfPlayer: currentPlayer, result: true, time: currentTime, zone: currentZone)
        }
        
        let no = UIAlertAction(title: "Lose", style: .default) {  [self] UIAlertAction in
            model.inputAttack(teamA: currentTeamA!, numOfPlayer: currentPlayer, result: false, time: currentTime, zone: currentZone)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(win)
        alert.addAction(no)
        alert.addAction(cancel)
        
        return alert
    }
    
    private func getAllScore()
    {
        if currentPlayer != ""
        {
            if let newView = view as? GameView
            {
                var titles = model.getAllScore(teamA: self.currentTeamA!, player: self.currentPlayer)
                newView.changeTitleOfLabelOfField(titles: titles)
            }
        }
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
    
    // MARK: FUNCS RETURNING SOME VALUES FOR VIEW
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
