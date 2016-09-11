//
//  BoardCalculations.swift
//  drago
//
//  Created by Dmitriy on 9/11/16.
//  Copyright © 2016 Glowman. All rights reserved.
//

import Foundation

class BoardCalculations {
    let grid: Grid
    
    init(grid: Grid) {
        self.grid = grid
    }
    
    func getKilledStones(point: Point, stoneType: StoneType) -> [Point] {
        let pointsToCheck = aroundPoints(for: point).filter { isPoint(point: $0, ofType: stoneType.opponent) }
        
        return pointsToCheck.reduce([]) { (result: [Point], point) in
            guard !result.contains(point) else { return result }
            return result + getDeadStones(point: point, stoneType: stoneType.opponent)
        }
    }

    func getDeadStones(point: Point, stoneType: StoneType) -> [Point] {
        return getDeadStones(stoneType: stoneType, deadList: [], freshList: [point])
    }
    
    private func getDeadStones(stoneType: StoneType,
                               deadList: [Point],
                               freshList: [Point]) -> [Point] {
        if freshList.isEmpty { return deadList }
        
        var freshList = freshList // make it mutable
        let freshPoint = freshList.remove(at: 0)
        
        if grid[freshPoint.x][freshPoint.y].stone == nil {
            return [] // no dead stones because of empty field
        }
        
        
        let newPoints = aroundPoints(for: freshPoint)
            .filter { !isOutOfBorder(x: $0.x, y: $0.y, board: self.grid) }
            .filter {
                isPoint(point: $0, ofType: stoneType) ||
                grid[$0.x][$0.y].stone == nil
            }.filter {
                !deadList.contains($0)
        }
        
        return getDeadStones(stoneType: stoneType, deadList: deadList + [freshPoint], freshList: freshList + newPoints)
        
    }
    
    private func aroundPoints(for point: Point) -> [Point] {
        return [
            Point(x: point.x + 1, y: point.y),
            Point(x: point.x - 1, y: point.y),
            Point(x: point.x, y: point.y + 1),
            Point(x: point.x, y: point.y - 1)
        ]
    }
    
    private func isPoint(point: Point, ofType type: StoneType) -> Bool {
        guard !isOutOfBorder(x: point.x, y: point.y, board: grid) else {
            return false
        }
        
        return grid[point.x][point.y].stone == type
    }

}
