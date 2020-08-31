//
//  GameModelAI.swift
//  TicTacToe
//
//  Created by Michał Nowak on 30/08/2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

class GameModelAI: GameModel {
    var searchingDepth: Int = 5
    
    init(boardSize: Int, player: Player) {
        var players: [Player] = []
        players.append(player)
        players.append(Player(name: "Player AI", symbol: PlayerSymbol.Cross))
        
        super.init(boardSize: boardSize, playersList: players)
    }
    
    public func makeMoveAI() {
        guard actualPlayer.name == "Player AI" else {
            return
        }
        
        let selectedPosition: (column: Int, row: Int) = minMaxMove(board: board, player: playersList[0], opponent: playersList[1], depth: searchingDepth)
        guard board.table[selectedPosition.column][selectedPosition.row] == 0 else {
            return
        }
        
        board.makeMove(player: actualPlayer, position: selectedPosition)
        update()
    }
}
