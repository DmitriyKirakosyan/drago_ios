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

struct Point: Equatable {
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
    
    var strValue: String {
        return "\(self.x)x\(self.y)"
    }
    
    static func ==(lhs: Point, rhs: Point) -> Bool
    {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
}

enum StoneType {
    case Black, White
    
    var opponent: StoneType { return self == .Black ? .White : .Black }
}

struct Stone: Equatable {
    let type: StoneType
    let point: Point
    
    init(type: StoneType, point: Point) {
        self.type = type
        self.point = point
    }
    
    static func ==(lhs: Stone, rhs: Stone) -> Bool
    {
        return lhs.point.x == rhs.point.x && lhs.point.y == rhs.point.y && lhs.type == rhs.type
    }

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
    
    private let grid: Grid
    
    private var currentTurn = StoneType.Black
    
    private var boardCalculations: BoardCalculations
    private var moveChecker: MovePosibilityChecker
    
    // ui callbacks
    var stoneAdded: ((Stone) -> ())?
    var stonesRemoved: (([Stone]) -> ())?

    init() {
        grid = BoardMaker.standardBoard()
        boardCalculations = BoardCalculations(grid: grid)
        moveChecker = MovePosibilityChecker(grid: grid)
        
        guard grid.count == BoardModel.BoardSize && grid[0].count == BoardModel.BoardSize else {
            print("ERROR! Board is wrong sized")
            return
        }
        
    }
    
    func canMove(point: Point) -> Bool {
        return moveChecker.canMove(point: point, stoneType: currentTurn)
    }
    
    func whosTurn() -> StoneType {
        return currentTurn
    }
    
    func makeMove(point: Point) {
        guard canMove(point: point) else {
            print("ERROR! [BoardMode] can't add stone to the field : \(point)")
            return
        }

        grid[point.x][point.y].stone = currentTurn
        // notify view
        stoneAdded?(Stone(type: currentTurn, point: point))

        let killedStones = boardCalculations.getKilledStones(point: point, stoneType: currentTurn)
        if !killedStones.isEmpty {
            removeStones(stones: killedStones)
            stonesRemoved?(killedStones.map{ Stone(type: currentTurn.opponent, point: $0) } )
        } else {
            let selfKilledStones = boardCalculations.getDeadStones(point: point, stoneType: currentTurn)
            if !selfKilledStones.isEmpty {
                removeStones(stones: selfKilledStones)
                stonesRemoved?(selfKilledStones.map{ Stone(type: currentTurn, point: $0) } )                
            }
        }
        currentTurn = currentTurn.opponent
        
    }
    
    
    //MARK: Private methods
    
    private func removeStones(stones: [Point]) {
        stones.forEach { grid[$0.x][$0.y].stone = nil }
    }
}
