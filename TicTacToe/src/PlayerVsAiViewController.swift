//
//  PlayerVsAiViewController.swift
//  TicTacToe
//
//  Created by Michał Nowak on 30/08/2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation
import UIKit

class PlayerVsAiViewController: UIViewController {
    var gameModel: GameModelAI!
    let gameModelQueue: DispatchQueue = DispatchQueue.init(label: "gameModelQueue")
    let mainQueue: DispatchQueue = DispatchQueue.main
    
    override func viewDidLoad() {
        let player = Player(name: "Player1", symbol: PlayerSymbol.Circle)
        
        gameModelQueue.async {
            self.gameModel = GameModelAI.init(boardSize: 3, player: player)
            self.mainQueue.async { self.updateUI() }
            self.gameModel.makeMoveAI()
            self.mainQueue.async { self.updateUI() }
        }
    }
    
    func updateUI() {
        if gameModel.gameStatus != BoardStatus.continues {
            switch gameModel.gameStatus {
            case BoardStatus.win:
                communicates.text = gameModel.actualPlayer.name + " wins !"
            default:
                communicates.text = "Draw !"
            }
            
            continueButton.isHidden = false
            blockButtons()
        }
        
        Player1Name.text = gameModel.playersList[0].name
        Player1Symbol.text = symbolToIcon(symbol: gameModel.playersList[0].symbol)
        Player1Points.text = String(gameModel.playersList[0].points)
        
        Player2Name.text = gameModel.playersList[1].name
        Player2Symbol.text = symbolToIcon(symbol: gameModel.playersList[1].symbol)
        Player2Points.text = String(gameModel.playersList[1].points)
        
        ActualPlayerName.text = gameModel.actualPlayer.name
        ActualPlayerSymbol.text = symbolToIcon(symbol: gameModel.actualPlayer.symbol)
        
        if gameModel.gameStatus != BoardStatus.win && gameModel.gameStatus != BoardStatus.draw {
            continueButton.isHidden = true
            communicates.text = ""
        }
        
        boardToButtons()
    }
    
    private func symbolToIcon(symbol: PlayerSymbol) -> String {
        switch symbol.rawValue {
        case 0:
            return "Null"
        case 1:
            return "⭕️"
        case 2:
            return "❌"
        default:
            return "Null"
        }
    }
    
    public func buttonIDtoPosition(id: String) -> (Int, Int) {
        switch id {
        case "Button00":
            return (0, 0)
        case "Button01":
            return (0, 1)
        case "Button02":
            return (0, 2)
        case "Button10":
            return (1, 0)
        case "Button11":
            return (1, 1)
        case "Button12":
            return (1, 2)
        case "Button20":
            return (2, 0)
        case "Button21":
            return (2, 1)
        case "Button22":
            return (2, 2)
        default:
            return (0, 0)
        }
    }
    
    public func boardToButtons() {
        if gameModel.board.table[0][0] != 0 {
            Button00.setTitle(symbolToIcon(symbol: PlayerSymbol(rawValue: gameModel.board.table[0][0])!), for: .normal);
            Button00.isUserInteractionEnabled = false
        }
        if gameModel.board.table[0][1] != 0 {
            Button01.setTitle(symbolToIcon(symbol: PlayerSymbol(rawValue: gameModel.board.table[0][1])!), for: .normal);
            Button01.isUserInteractionEnabled = false
        }
        if gameModel.board.table[0][2] != 0 {
            Button02.setTitle(symbolToIcon(symbol: PlayerSymbol(rawValue: gameModel.board.table[0][2])!), for: .normal);
            Button02.isUserInteractionEnabled = false
        }
        
        if gameModel.board.table[1][0] != 0 {
            Button10.setTitle(symbolToIcon(symbol: PlayerSymbol(rawValue: gameModel.board.table[1][0])!), for: .normal);
            Button10.isUserInteractionEnabled = false
        }
        if gameModel.board.table[1][1] != 0 {
            Button11.setTitle(symbolToIcon(symbol: PlayerSymbol(rawValue: gameModel.board.table[1][1])!), for: .normal);
            Button11.isUserInteractionEnabled = false
        }
        if gameModel.board.table[1][2] != 0 {
            Button12.setTitle(symbolToIcon(symbol: PlayerSymbol(rawValue: gameModel.board.table[1][2])!), for: .normal);
            Button12.isUserInteractionEnabled = false
        }
        
        if gameModel.board.table[2][0] != 0 {
            Button20.setTitle(symbolToIcon(symbol: PlayerSymbol(rawValue: gameModel.board.table[2][0])!), for: .normal);
            Button20.isUserInteractionEnabled = false
        }
        if gameModel.board.table[2][1] != 0 {
            Button21.setTitle(symbolToIcon(symbol: PlayerSymbol(rawValue: gameModel.board.table[2][1])!), for: .normal);
            Button21.isUserInteractionEnabled = false
        }
        if gameModel.board.table[2][2] != 0 {
            Button22.setTitle(symbolToIcon(symbol: PlayerSymbol(rawValue: gameModel.board.table[2][2])!), for: .normal);
            Button22.isUserInteractionEnabled = false
        }
    }
    
    private func clearButtons() {
        Button00.setTitle("", for: .normal); Button00.isUserInteractionEnabled = true
        Button01.setTitle("", for: .normal); Button01.isUserInteractionEnabled = true
        Button02.setTitle("", for: .normal); Button02.isUserInteractionEnabled = true
        Button10.setTitle("", for: .normal); Button10.isUserInteractionEnabled = true
        Button11.setTitle("", for: .normal); Button11.isUserInteractionEnabled = true
        Button12.setTitle("", for: .normal); Button12.isUserInteractionEnabled = true
        Button20.setTitle("", for: .normal); Button20.isUserInteractionEnabled = true
        Button21.setTitle("", for: .normal); Button21.isUserInteractionEnabled = true
        Button22.setTitle("", for: .normal); Button22.isUserInteractionEnabled = true
    }
    
    private func unBlockButtons() {
        Button00.isUserInteractionEnabled = true
        Button01.isUserInteractionEnabled = true
        Button02.isUserInteractionEnabled = true
        Button10.isUserInteractionEnabled = true
        Button11.isUserInteractionEnabled = true
        Button12.isUserInteractionEnabled = true
        Button20.isUserInteractionEnabled = true
        Button21.isUserInteractionEnabled = true
        Button22.isUserInteractionEnabled = true
    }
    
    private func blockButtons() {
        Button00.isUserInteractionEnabled = false
        Button01.isUserInteractionEnabled = false
        Button02.isUserInteractionEnabled = false
        Button10.isUserInteractionEnabled = false
        Button11.isUserInteractionEnabled = false
        Button12.isUserInteractionEnabled = false
        Button20.isUserInteractionEnabled = false
        Button21.isUserInteractionEnabled = false
        Button22.isUserInteractionEnabled = false
    }
    
    // @IBOutlet's
    @IBOutlet weak var Player1Name: UILabel!
    @IBOutlet weak var Player1Symbol: UILabel!
    @IBOutlet weak var Player1Points: UILabel!
    
    @IBOutlet weak var Player2Name: UILabel!
    @IBOutlet weak var Player2Symbol: UILabel!
    @IBOutlet weak var Player2Points: UILabel!
    
    @IBOutlet weak var ActualPlayerName: UILabel!
    @IBOutlet weak var ActualPlayerSymbol: UILabel!
    
    @IBOutlet weak var Button00: UIButton!
    @IBOutlet weak var Button01: UIButton!
    @IBOutlet weak var Button02: UIButton!
    @IBOutlet weak var Button10: UIButton!
    @IBOutlet weak var Button11: UIButton!
    @IBOutlet weak var Button12: UIButton!
    @IBOutlet weak var Button20: UIButton!
    @IBOutlet weak var Button21: UIButton!
    @IBOutlet weak var Button22: UIButton!
    
    @IBOutlet weak var communicates: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    // @IBAction's
    @IBAction func buttonPressed(_ sender: UIButton) {
        let position = buttonIDtoPosition(id: sender.restorationIdentifier!)
        
        gameModelQueue.async {
            self.gameModel.playerMakeMove(selectedPosition: position)
            self.mainQueue.async {
                self.blockButtons()
                self.updateUI()
            }
            sleep(1)
            self.gameModel.makeMoveAI()
            self.mainQueue.async {
                self.unBlockButtons()
                self.updateUI()
            }
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        gameModelQueue.async {
            self.mainQueue.async {
                self.clearButtons()
                self.updateUI()
            }
            self.gameModel.newRound()
            self.gameModel.makeMoveAI()
            self.mainQueue.sync {
                self.clearButtons()
                self.updateUI()
            }
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        self.mainQueue.async {
            self.clearButtons()
            self.viewDidLoad()
        }
    }
}
