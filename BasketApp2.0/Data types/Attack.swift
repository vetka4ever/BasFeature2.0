//
//  Attack.swift
//  BasketApp2.0
//
//  Created by Daniil on 16.12.2021.
//

import UIKit
class Attack: Codable
{
    private var time: String
    private var player: String
    private var zone: String
    private var status: String
    
    init(time: String, player: String, zone: String, status: String)
    {
        self.time = time
        self.player = player
        self.zone = zone
        self.status = status
    }
    
}
