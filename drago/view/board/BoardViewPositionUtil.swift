//
//  BoardViewPositionUtil.swift
//  drago
//
//  Created by Dmitriy on 9/9/16.
//  Copyright © 2016 Glowman. All rights reserved.
//

import SpriteKit

class BoardViewPositionUtil {
    private let actualBoardSize: CGSize = CGSize(width: 360, height: 360)
    private let boardBorder: CGFloat = 53
    private let fieldSize: CGFloat = 36

    private let boardSize: CGSize

    init(boardSize: CGSize) {
        self.boardSize = boardSize
    }
    
    func gridPoint(for location: CGPoint) -> Point {
        // starting from center
        let positionInBoard = CGPoint(x: location.x + actualBoardSize.width/2 + fieldSize/2,
                                      y: location.y + actualBoardSize.height/2 + fieldSize/2)
        
        
        var resultX = Int(positionInBoard.x / fieldSize)
        var resultY = Int(positionInBoard.y / fieldSize)
        
        
        if resultX < 0 { resultX = 0 }
        if resultY < 0 { resultY = 0 }
        
        if resultX >= BoardModel.BoardSize { resultX = BoardModel.BoardSize - 1 }
        if resultY >= BoardModel.BoardSize { resultY = BoardModel.BoardSize - 1 }
        
        
        return Point(x: resultX, y: resultY)
    }
    
    func location(for gridPoint: Point) -> CGPoint {
        return CGPoint(x: gridPoint.adoptedX() * fieldSize - actualBoardSize.width/2,
                       y: gridPoint.adoptedY() * fieldSize - actualBoardSize.height/2)
    }
}
