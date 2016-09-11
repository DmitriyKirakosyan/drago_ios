//
//  BoardUtil.swift
//  drago
//
//  Created by Dmitriy on 9/11/16.
//  Copyright © 2016 Glowman. All rights reserved.
//

import Foundation

func isOutOfBorder(x: Int, y: Int, board: Grid) -> Bool {
    guard !board.isEmpty else { return true }
    
    return x < 0 || y < 0 || x >= board.count || y >= board[0].count
}
