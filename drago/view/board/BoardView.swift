//
//  BoardView.swift
//  drago
//
//  Created by Dmitriy on 9/8/16.
//  Copyright © 2016 Glowman. All rights reserved.
//

import SpriteKit

class BoardView: SKSpriteNode {
    private let actualBoardSize: CGSize = CGSize(width: 275, height: 275)
    private let boardBorder: CGFloat = 38
    private let fieldSize: CGFloat = 28
    
    private(set) var player1Score: Int = 0
    private(set) var player2Score: Int = 0
    private(set) var playerToMove: StoneType = .Black
    
    private(set) lazy var positionUtil: BoardViewPositionUtil = {
        return BoardViewPositionUtil(boardSize: self.size)
    }()
    
    private var stoneViews = [String: SKSpriteNode]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //        actualBoardSize = self.size.applying(CGAffineTransform(scaleX: 0.8, y: 0.8))
        //        boardBorder = self.size.width / 10
        
        
        print("board size : \(self.size)")
        print("actual board size : \(actualBoardSize)")
        
        print("board frame : \(self.frame)")
    }

    func stoneLocationFor(point: CGPoint) -> Point {
        return positionUtil.gridPoint(for: CGPoint(x: point.x + self.position.x,
                                                   y: point.y + self.position.y))
    }
    
    func addStone(point: Point, stoneType: StoneType) {
        print("stone grid position : \(point)")
        
        let location = positionUtil.location(for: point)
        
        print("stone position in view : \(location)")
        
        let stone = SKSpriteNode(imageNamed: stoneType == .White ? "white_stone" : "black_stone")
        
        stoneViews[point.strValue] = stone
        
        stone.position = location// CGPoint(x: 100, y: 100)
        stone.zPosition = 1
        self.addChild(stone)
    }
    
    func removeStone(at point: Point) {
        if let stoneView = stoneViews[point.strValue] {
            self.removeChildren(in: [stoneView])
        }
    }
 
}
