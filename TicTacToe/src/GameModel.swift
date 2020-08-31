//
//  GameModel.swift
//  TicTacToe
//
//  Created by Michał Nowak on 27/08/2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

class GameModel {
    var playersList: [Player]
    var board: Board
    var gameStatus: BoardStatus
    var movementsSequence: [Int]
    var actualPlayerIndex: Int
    var actualPlayer: Player {
        get {
            return playersList[actualPlayerIndex]
        }
    }
    var settings: Settings = Settings()
    
    init(boardSize: Int, playersList: [Player]) {
        settings.load()
        
        self.playersList = playersList
        self.movementsSequence = []
        self.board = Board.init(size: boardSize)
        self.gameStatus = BoardStatus.continues
        self.movementsSequence = []
        self.actualPlayerIndex = 0
        
        generateMovementsSequence()
        changeActualPlayer()
    }
    
    public func update() {
        gameStatus = boardCheck()
        
        switch gameStatus {
        case BoardStatus.continues:
            changeActualPlayer()
            break
        case BoardStatus.win:
            addPointActualPlayer()
            break
        case BoardStatus.draw:
            changeActualPlayer()
            break
        }
    }
    
    public func playerMakeMove(selectedPosition: (column: Int, row: Int)) {
        guard board.table[selectedPosition.column][selectedPosition.row] == 0 else {
            return
        }
        
        board.makeMove(player: actualPlayer, position: selectedPosition)
        
        update()
    }
    
    public func newRound() {
        board.clear()
        gameStatus = BoardStatus.continues
        generateMovementsSequence()
        changeActualPlayer()
    }
    
    public func printBoard() {
        board.printBoard()
    }
    
    private func generateMovementsSequence() {
        movementsSequence = []
        
        let playersCount = playersList.count
        let movesCount = (board.size * board.size)
        
        var move = Int.random(in: 0...playersCount-1)
        movementsSequence.append(move)
        
        for _ in 0...movesCount-2 {
            move += 1
            movementsSequence.append(move % playersCount)
        }
    }
    
    private func boardCheck() -> BoardStatus {
        let gameResult = board.check(player: actualPlayer)
        return gameResult
    }
    
    private func changeActualPlayer() {
        if !movementsSequence.isEmpty {
            actualPlayerIndex = movementsSequence.first!
            movementsSequence.removeFirst()
        }
    }
    
    private func addPointActualPlayer() {
        playersList[actualPlayerIndex].points += 1
    }
}
