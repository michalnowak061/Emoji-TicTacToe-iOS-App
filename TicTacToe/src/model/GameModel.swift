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
    var actualRound: Int
    var roundsNumber: Int
    var settings: Settings = Settings()
    var settingsErrorCode: SettingsErrorCodes!
    
    init(boardSize: Int, playersList: [Player]) {
        settingsErrorCode = settings.load()
        
        self.playersList = playersList
        self.movementsSequence = []
        self.board = Board.init(size: boardSize)
        self.gameStatus = BoardStatus.continues
        self.movementsSequence = []
        self.actualPlayerIndex = 0
        self.actualRound = 1
        self.roundsNumber = settings.roundsNumber
        
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
        guard board.table[selectedPosition.column][selectedPosition.row] == "0" else {
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
        actualRound += 1
    }
    
    public func findWinner() -> Player? {
        var counter = 0
        var winner = playersList[0]
        for player in playersList {
            if player.points > winner.points {
                winner = player
            }
            else if player.points == winner.points {
                counter += 1
            }
        }
        if counter < playersList.count {
            return winner
        }
        else {
            return nil
        }
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
