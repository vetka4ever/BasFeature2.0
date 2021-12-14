//
//  Players.swift
//  BasketApp2.0
//
//  Created by Daniil on 12.12.2021.
//

import Foundation
class Player: Codable
{
    var name: String,
        number: String,
        dateOfBirth: String,
        height: String,
        weight: String
    
    init(player: dataOfPlayer)
    {
        self.name = player.name
        self.number = player.number
        self.dateOfBirth = player.dateOfBirth
        self.height = player.height
        self.weight = player.weight
    }
}

//    var accessToName: String
//    {
//        get
//        {
//            return name
//        }
//        set
//        {
//            self.name = newValue
//        }
//    }
//
//    var accessToNumber: String
//    {
//        get
//        {
//            return number
//        }
//        set
//        {
//            self.number = newValue
//        }
//    }


