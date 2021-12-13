//
//  Players.swift
//  BasketApp2.0
//
//  Created by Daniil on 12.12.2021.
//

import Foundation
class Player: Codable
{
    private var name = ""
    private var number = ""
    private var dateOfBirth = ""
    private var height = ""
    private var weight = ""
    
    var accessToName: String
    {
        get
        {
            return name
        }
        set
        {
            self.name = newValue
        }
    }
    
    var accessToNumber: String
    {
        get
        {
            return number
        }
        set
        {
            self.number = newValue
        }
    }
    
}
