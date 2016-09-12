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
    
    var strValue: String {
        switch self {
        case .Black:
            return "Black"
        default:
            return "White"
        }
    }
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
    var score = 0
    
    init(score: Int) {
        self.score = score
    }
}

class BoardModel {
    static let BoardSize = 11
    
    private let grid: Grid
    
    
    private var moveChecker: MovePosibilityChecker
    
    // ui callbacks
    var stoneAdded: ((Stone) -> ())?
    var stoneRemoved: ((Stone) -> ())?

    init(grid: Grid) {
        self.grid = grid
        moveChecker = MovePosibilityChecker(grid: grid)
        
        guard grid.count == BoardModel.BoardSize && grid[0].count == BoardModel.BoardSize else {
            print("ERROR! Board is wrong sized")
            return
        }
        
    }
    
    func canMove(point: Point) -> Bool {
        return moveChecker.canMove(point: point)
    }
 
    // Returns score for given point
    func addStone(point: Point, stone: StoneType) -> Int {
        grid[point.x][point.y].stone = stone
        // notify view
        stoneAdded?(Stone(type: stone, point: point))
        
        return grid[point.x][point.y].score
    }
    
    func removeStones(points: [Point]) {
        points.forEach { point in
            if let stoneType = self.grid[point.x][point.y].stone {
                self.grid[point.x][point.y].stone = nil
                self.stoneRemoved?(Stone(type: stoneType, point: point))
            } else {
                print("[BoardModel] ERROR! Can't remove stone from empy field : \(point)")
            }
        }
    }
    
    //MARK: Private methods
    
//    private func removeFromGrid(points: [Point]) {
//        points.forEach { grid[$0.x][$0.y].stone = nil }
//    }
}
