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
    
    private var boardView: BoardView!
    private var infoLabel: SKLabelNode!
    private var player1ScoreLabel: SKLabelNode!
    private var player2ScoreLabel: SKLabelNode!
    private var whowsToMoveLabel: SKLabelNode!
    
    private var model = GameModel()
    
    override func sceneDidLoad() {

        model.boardModel.stoneAdded = self.onStoneAdded
        model.boardModel.stoneRemoved = self.onStoneRemoved
        model.scoreUpdated = self.onScoreUpdated
        model.turnChanged = self.turnChanged
        
        // Get label node from scene and store it for use later
        boardView = self.childNode(withName: "//board") as! BoardView
        
        infoLabel = self.childNode(withName: "//infolabel") as! SKLabelNode
        whowsToMoveLabel = self.childNode(withName: "//moveLabel") as! SKLabelNode
        player1ScoreLabel = self.childNode(withName: "//player1_score") as! SKLabelNode
        player2ScoreLabel = self.childNode(withName: "//player2_score") as! SKLabelNode
        
        model.startGame()
        
//        print("size : \(self.size)")
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            print("location in self : \(location)")
            if boardView?.contains(location) ?? false {
                let stonePosition = boardView.stoneLocationFor(point: location)
                
                let point = boardView.positionUtil.gridPoint(for: location)
                
                if model.boardModel.canMove(point: point) {
                    model.makeMove(point: point)
                }
                
                infoLabel.text = "position : \(stonePosition)"
            }
        }
        
    }
    
    
    //MARK Model Callbaks
    
    private func onStoneAdded(stone: Stone) {
        boardView.addStone(point: stone.point, stoneType: stone.type)
    }
    
    private func onStoneRemoved(stone: Stone) {
        boardView.removeStone(at: stone.point)
    }
    
    private func onScoreUpdated() {
        player1ScoreLabel.text = "score: \(model.player1.score), cap: \(model.player1.captures)"
        player2ScoreLabel.text = "score: \(model.player2.score), cap: \(model.player2.captures)"
    }
    
    private func turnChanged(turn: StoneType) {
        whowsToMoveLabel.text = "To move: \(turn.strValue)"
    }

}
