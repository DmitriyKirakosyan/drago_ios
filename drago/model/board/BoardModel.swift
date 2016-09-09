//
//  BoardModel.swift
//  drago
//
//  Created by Dmitriy on 9/5/16.
//  Copyright © 2016 Glowman. All rights reserved.
//

import Foundation
import SpriteKit

typealias Grid = [[BoardField]]
//typealias Point = (x: Int, y: Int)

struct Point {
    let x: Int
    let y: Int
    
    func adoptedX() -> CGFloat {
        return CGFloat(x)
    }
    func adoptedY() -> CGFloat {
        return CGFloat(y)
    }
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
}

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
