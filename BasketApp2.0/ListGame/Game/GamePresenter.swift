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
        doingByMode()
    }
    
    func setPlayer(teamA: Bool, player: String)
    {
        if let newView = view as? GameView
        {
            if player == "" && currentTeamA != nil
            {
                newView.reloadTableView(teamA: currentTeamA!)
            }
        }
        
        self.currentTeamA = teamA
        self.currentPlayer = player
        print("Current Team - \(currentTeamA)")
        print("Current Player - \(currentPlayer)")
        doingByMode()
    }
    
    func setMode(mode: Int)
    {
        if let newView = view as? GameView
        {
            newView.changeVisibleElementsOfField(turnOn: mode != Mode.input.rawValue)
            if mode * currentMode.rawValue == 0
            {
                newView.changeEnableForTeamButtons(turnOn: (mode != 0))
            }
        }
        
        self.currentMode = Mode.init(rawValue: mode)!
        
        if mode != Mode.input.rawValue
        {
            self.currentZone = 0
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
        if let newView = view as? GameView
        {
            if let team = self.currentTeamA
            {
                let titles = model.getAllScore(teamA: team, player: self.currentPlayer, time: self.currentTime)
                newView.changeTitleOfLabelOfField(titles: titles)
            }
            
            
        }
        
    }
    
    private func getScoredScore()
    {
        if let newView = view as? GameView
        {
            if let team = self.currentTeamA
            {
                let titles = model.getScoredScore(teamA: team, player: self.currentPlayer, time: self.currentTime)
                newView.changeTitleOfLabelOfField(titles: titles)
            }
        }
    }
    
    private func getShotScore()
    {
        if let newView = view as? GameView
        {
            if let team = self.currentTeamA
            {
                let titles = model.getShotScore(teamA: team, player: self.currentPlayer, time: self.currentTime)
                newView.changeTitleOfLabelOfField(titles: titles)
            }
        }
    }
    
    private func endGame()
    {
        view.present(exitAlert(), animated: true, completion: nil)
    }
    
    private func exitAlert() -> UIAlertController
    {
        let alert = UIAlertController(title: "Warning", message: "Are you sure you wanna leave game?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .destructive) { UIAlertAction in
            self.model.saveGame()
            
            self.view.navigationController?.popToRootViewController(animated: true)
        }
        let no = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        return alert
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
    
    func getSelectedTeam() -> Bool?
    {
        return currentTeamA
    }
    
    func getCurrentMode() -> Mode
    {
        return currentMode
    }
}
