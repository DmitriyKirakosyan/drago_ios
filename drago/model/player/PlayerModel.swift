//
//  PlayerModel.swift
//  drago
//
//  Created by Dmitriy on 9/13/16.
//  Copyright © 2016 Glowman. All rights reserved.
//

import Foundation

class PlayerModel {

    var captures: Int = 0
    var score: Int = 0
    var name: String
    var stone: StoneType
    
    init(name: String, stone: StoneType) {
        self.name = name
        self.stone = stone
    }
    
    
}
