//
//  GameScene.swift
//  drago
//
//  Created by Dmitriy on 9/3/16.
//  Copyright © 2016 Glowman. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var spinnyNode : SKShapeNode?
    
    private var boardView: BoardView!
    private var infoLabel: SKLabelNode!
    
    private var boardModel = BoardModel()
    
    override func sceneDidLoad() {
        
        // Get label node from scene and store it for use later
        boardView = self.childNode(withName: "//board") as! BoardView
        boardView.model = boardModel
        
        infoLabel = self.childNode(withName: "//infolabel") as! SKLabelNode
        
        print("size : \(self.size)")
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            print("location in self : \(location)")
            if boardView?.contains(location) ?? false {
                let stonePosition = boardView.stoneLocationFor(point: location)
                
                let point = boardView.positionUtil.gridPoint(for: location)
                if boardModel.canMove(point: point) {
                    boardModel.makeMove(point: point)
                }
                
//                boardView.addStone(point: stonePosition, stoneType: stoneType)
                
                infoLabel.text = "position : \(stonePosition), next turn : \(boardModel.whosTurn())"
            }
        }
        
    }
    
    
}
