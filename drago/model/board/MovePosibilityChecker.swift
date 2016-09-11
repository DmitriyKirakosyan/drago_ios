//
//  MovePosibilityChecker.swift
//  drago
//
//  Created by Dmitriy on 9/9/16.
//  Copyright © 2016 Glowman. All rights reserved.
//

import UIKit

class MovePosibilityChecker: NSObject {
    private let grid: Grid
    
    var koPoint: Point?
    
    init(grid: Grid) {
        self.grid = grid
    }
    
    func canMove(point: Point, stoneType: StoneType) -> Bool {
        
        guard !isOutOfBorder(x: point.x, y: point.y, board: grid) else {
            print("[MovePosibilityChecker] ERROR! x, y is ouf ot range : \(point)")
            return false
        }
        
        guard grid[point.x][point.y].stone == nil else {
            print("[MovePosibilityChecker] There is stone already")
            return false
        }
        
        // ko check
        guard koPoint == nil || (koPoint!.x != point.x || koPoint!.y != point.y) else {
            print("[MovePosibilityChecker] ko point, can't move there")
            return false
        }
        
        
//        // self kill check
//        guard getDeadStones(point: point, stoneType: stoneType) == [] else {
//            print("[MovePosibilityChecker] self killed, can't move there")
//            return false
//        }
        
        return true
    }
    

}
