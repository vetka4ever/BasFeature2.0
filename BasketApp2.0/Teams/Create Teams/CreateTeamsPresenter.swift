//
//  CreateTeamsPresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 12.12.2021.
//

import UIKit
import RealmSwift
class CreateTeamsPresenter
{
    enum StateOfName
    {
        case okay
        case empty
    }
    private let model = CreateTeamsModel()
    private var view = UIViewController()
   
    func setView(view: CreateTeamsView)
    {
        self.view = view
    }

    func addTeam(nameOfTeam: String)
    {
        
        if let newView = view as? CreateTeamsView
        {
            if checkNameOfTeam(nameOfTeam: nameOfTeam) == .empty
            {
                newView.alertAboutEmptyNameOfTeam()
            }
            else
            {
                model.createTeam(nameOfTeam: nameOfTeam)
                
                newView.hideView()
            }
        }
        
    }
    
    private func checkNameOfTeam(nameOfTeam: String) -> StateOfName
    {
        var stateOfName: StateOfName
        var changebleNameOfTeam = nameOfTeam
        for item in changebleNameOfTeam
        {
            if item == " "
            {
                changebleNameOfTeam.removeFirst()
            }
        }
        (changebleNameOfTeam.isEmpty ? (stateOfName = .empty) : (stateOfName = .okay))
        
            return stateOfName
    }
}
