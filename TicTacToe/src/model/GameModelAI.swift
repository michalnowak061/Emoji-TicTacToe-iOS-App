//
//  GameModelAI.swift
//  TicTacToe
//
//  Created by Michał Nowak on 30/08/2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

class GameModelAI: GameModel {
    var searchingDepth: Int = 0
    
    override init(boardSize: Int, playersList: [Player]) {
        super.init(boardSize: boardSize, playersList: playersList)
        searchingDepth = settings.difficultLevel
    }
    
    public func makeMoveAI() {
        guard actualPlayer.name == "Komputer" else {
            return
        }
        
        let selectedPosition: (column: Int, row: Int) = minMaxMove(board: board, player: playersList[0], opponent: playersList[1], depth: searchingDepth)
        guard board.table[selectedPosition.column][selectedPosition.row] == "0" else {
            return
        }
        
        board.makeMove(player: actualPlayer, position: selectedPosition)
        update()
    }
}
