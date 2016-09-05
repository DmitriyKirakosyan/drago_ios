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
    
    private var boardView: SKSpriteNode?
    
    override func sceneDidLoad() {
        
        // Get label node from scene and store it for use later
        boardView = self.childNode(withName: "//board") as? SKSpriteNode
        
        print("size : \(self.size)")
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
        }
        
    }
    
}
