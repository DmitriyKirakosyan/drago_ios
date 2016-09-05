//
//  BoardModel.swift
//  drago
//
//  Created by Dmitriy on 9/5/16.
//  Copyright © 2016 Glowman. All rights reserved.
//

import Foundation


typealias Grid = [[BoardField]]


enum StoneType {
    case Black, White
}

class BoardField {
    var stone: StoneType?
    var bonusPoints = 0
    
    init(points: Int) {
        self.bonusPoints = points
    }
}

class BoardModel {
    static let BoardSize = 11
    
    let grid: Grid
    
    init() {
        grid = BoardMaker.standardBoard()
        
        guard grid.count == BoardModel.BoardSize && grid[0].count == BoardModel.BoardSize else {
            print("ERROR! Board is wrong sized")
            return
        }
        
    }
    
    
    //MARK: Private methods
    

}
