//
//  Attack.swift
//  BasketApp2.0
//
//  Created by Daniil on 16.12.2021.
//

import UIKit
class Attack: Codable
{
    private var time: Int
    private var player: String
    private var zone: Int
    private var status: Bool
    
    init(time: Int, player: String, zone: Int, status: Bool)
    {
        self.time = time
        self.player = player
        self.zone = zone
        self.status = status
    }
    
}
