//
//  GameModel.swift
//  TicTacToe
//
//  Created by Michał Nowak on 27/08/2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

struct GameModel {
    var playersList: [Player]?
    var actualPlayer: Player?
    var movementsSequence: [Int]
    var board: Board?
    var gameStatus: BoardStatus
    
    init(boardSize: Int) {
        playersList = []
        board = Board.init(size: boardSize)
        movementsSequence = []
        gameStatus = BoardStatus.anything
    }
    
    mutating func generateMovementsSequence() {
        if playersList != nil && board != nil {
            movementsSequence = []
            let playersCount = playersList!.count
            let movesCount = (board!.size * board!.size)
            
            var move = Int.random(in: 0...playersCount-1)
            movementsSequence.append(move)
            
            for _ in 0...movesCount-2 {
                move += 1
                movementsSequence.append(move % (playersCount))
            }
            
            actualPlayer = playersList![movementsSequence.first!]
        }
    }
    
    mutating func addPlayer(playerName: String, playerSymbol: Symbol) {
        let player = Player.init(name: playerName, symbol: playerSymbol)
        
        if playersList != nil {
            playersList!.append(player)
        }
    }
    
    mutating func makeMove(selectedPosition: (column: Int, row: Int)) {
        if board != nil && !movementsSequence.isEmpty {
            guard board!.table[selectedPosition.column][selectedPosition.row] == 0 else {
                return
            }

            var actualMove = movementsSequence.first!
            
            board!.makeMove(player: actualPlayer!, position: selectedPosition)
            gameStatus = boardCheck()
            if gameStatus == BoardStatus.win {
                playersList![actualMove].points += 1
            }
            movementsSequence.removeFirst()
            
            if movementsSequence.first != nil {
                actualMove = movementsSequence.first!
                actualPlayer = playersList![actualMove]
            }
        }
    }
    
    private func boardCheck() -> BoardStatus {
        if board != nil && !movementsSequence.isEmpty && playersList != nil {
            let actualMove = movementsSequence.first!
            let actualPlayer = playersList![actualMove]
            let gameResult = board!.check(player: actualPlayer)
            
            return gameResult
        }
        
        return BoardStatus.anything
    }
    
    mutating func newRound() {
        if board != nil {
            board!.clear()
        }
        gameStatus = BoardStatus.anything
        generateMovementsSequence()
    }
    
    func printBoard() {
        if board != nil {
            board!.printBoard()
        }
    }
}
