//
//  GameModel.swift
//  drago
//
//  Created by Dmitriy on 9/12/16.
//  Copyright © 2016 Glowman. All rights reserved.
//

import Foundation

class GameModel {
    
    private(set) var player1Score: Int = 0
    private(set) var player2Score: Int = 0
    private(set) var player1Captures: Int = 0
    private(set) var player2Captures: Int = 0
    
    let player1: PlayerModel
    let player2: PlayerModel
    
    let boardModel: BoardModel
    
    private var boardCalculations: BoardCalculations
    private var koPoint: Point?

    private var currentTurn = StoneType.Black

    var turnChanged: ((StoneType) -> ())?
    var scoreUpdated: (() -> ())?

    init() {
        let grid = BoardMaker.standardBoard()
        boardModel = BoardModel(grid: grid)
        boardCalculations = BoardCalculations(grid: grid)
        
        player1 = PlayerModel(name: "player 1", stone: .Black)
        player2 = PlayerModel(name: "player 2", stone: .White)
    }
    
    func startGame() {
        scoreUpdated?()
        currentTurn = .Black
        turnChanged?(currentTurn)
    }
    
    
    func whosTurn() -> StoneType {
        return currentTurn
    }
    
    func makeMove(point: Point) -> Bool {
        guard boardModel.canMove(point: point) else {
            print("ERROR! [BoardModel] can't add stone to the field : \(point)")
            return false
        }
        
        guard koPoint != point else {
            print("[BoardModel KO!")
            return false
        }
        koPoint = nil
        
        var playersUpdated = false
        let score = boardModel.addStone(point: point, stone: currentTurn)
        if score != 0 {
            currentPlayer.score += score;
            playersUpdated = true
        }
        
        let killedStones = boardCalculations.getKilledStones(point: point, stoneType: currentTurn)
        if !killedStones.isEmpty {
            // check if KO
            if killedStones.count == 1 {
                if boardCalculations.getDeadStones(point: point, stoneType: currentTurn).count == 1 {
                    koPoint = killedStones[0]
                }
            }

            boardModel.removeStones(points: killedStones)
            currentPlayer.captures += killedStones.count
            playersUpdated = true
        } else {
            let selfKilledStones = boardCalculations.getDeadStones(point: point, stoneType: currentTurn)
            if !selfKilledStones.isEmpty {
                boardModel.removeStones(points: selfKilledStones)
                opponent.captures += selfKilledStones.count
                playersUpdated = true
            }
        }
        
        if playersUpdated {
            scoreUpdated?()
        }
        
        currentTurn = currentTurn.opponent
        turnChanged?(currentTurn)
        
        return true
    }

    
    //MARK: Private methods
    
    private var currentPlayer: PlayerModel {
        return player1.stone == currentTurn ? player1 : player2
    }
    
    private var opponent: PlayerModel {
        return player1.stone == currentTurn ? player2 : player1
    }
}
