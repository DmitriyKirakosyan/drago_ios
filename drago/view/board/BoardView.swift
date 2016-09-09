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
    
    private lazy var positionUtil: BoardViewPositionUtil = {
        return BoardViewPositionUtil(boardSize: self.size)
    }()
    
    private var stoneViews = [SKSpriteNode]()
    
    var model: BoardModel?
    
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
        
//        let image = stoneType == .White ? #imageLiteral(resourceName: "white_stone") : #imageLiteral(resourceName: "black_stone")
//        let stone = SKSpriteNode(texture: SKTexture(image: image))
        let stone = SKSpriteNode(imageNamed: stoneType == .White ? "white_stone" : "black_stone")
        stoneViews.append(stone)
        
        
        stone.position = location// CGPoint(x: 100, y: 100)
        stone.zPosition = 1
        self.addChild(stone)
    }
    
}
