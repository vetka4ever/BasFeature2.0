//
//  AddPlayerPresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 14.12.2021.
//

import UIKit
class AddPlayerPresenter
{
    
    private let model = AddPlayerModel()
    private var view = UIViewController()
    
    func setView(view: AddPlayerView)
    {
        self.view = view
    }
    
    func addPlayer(player: dataOfPlayer)
    {
        model.addPlayer(player: player)
        if let newView = view as? AddPlayerView
        {
            newView.popView()
        }
    }
    
}
