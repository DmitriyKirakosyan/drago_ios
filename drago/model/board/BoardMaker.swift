//
//  BoardMaker.swift
//  drago
//
//  Created by Dmitriy on 9/5/16.
//  Copyright © 2016 Glowman. All rights reserved.
//

import Foundation

class BoardMaker {
    private static let standardBoardScheme =
        [
            [0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, -5, 0, 0, 0, 0, 0, -5, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, -5, 0, 0, 0, 0, 0, -5, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0]
    ]
    
    class func standardBoard() -> Grid {
        return standardBoardScheme.map { line in
            line.map { item in
                BoardField(score: item)
            }
        }
    }
}
