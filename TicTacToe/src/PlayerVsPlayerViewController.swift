//
//  PlayerVsPlayerViewController.swift
//  TicTacToe
//
//  Created by Michał Nowak on 27/08/2020.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class PlayerVsPlayerViewController: UIViewController {
    var gameModel: GameModel!
    static var players: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        gameModel = GameModel.init(boardSize: 3, playersList: PlayerVsPlayerViewController.players)
        updateUI()
    }
    
    private func updateUI() {
        if gameModel.gameStatus != BoardStatus.continues {
            switch gameModel.gameStatus {
            case BoardStatus.win:
                communicates.text = ActualPlayerName.text! + " wygrywa rundę"
            case BoardStatus.draw:
                communicates.text = "Runda zakończona remisem"
            default:
                break
            }
            continueButton.isHidden = false
            blockButtons()
        }
        
        Player1Name.text = gameModel.playersList[0].name
        Player1Symbol.text = gameModel.playersList[0].symbol
        Player1Points.text = String(gameModel.playersList[0].points)
        
        Player2Name.text = gameModel.playersList[1].name
        Player2Symbol.text = gameModel.playersList[1].symbol
        Player2Points.text = String(gameModel.playersList[1].points)
        
        actualRound.text = String(gameModel.actualRound) + " / " + String(gameModel.roundsNumber)
        
        ActualPlayerName.text = gameModel.actualPlayer.name
        ActualPlayerSymbol.text = gameModel.actualPlayer.symbol
        
        if gameModel.gameStatus != BoardStatus.win && gameModel.gameStatus != BoardStatus.draw {
            continueButton.isHidden = true
            communicates.text = ""
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            switch id {
            case "showGameResultViewController":
                guard let gameResultVC: GameResultViewController = segue.destination as? GameResultViewController else {
                    return
                }
                gameResultVC.previousViewControllerID = self.restorationIdentifier
                gameResultVC.winner = self.gameModel.findWinner()
            default:
                break
            }
        }
    }
    
    // @IBOutlet's
    @IBOutlet weak var Player1Name: UILabel!
    @IBOutlet weak var Player1Symbol: UILabel!
    @IBOutlet weak var Player1Points: UILabel!
    
    @IBOutlet weak var Player2Name: UILabel!
    @IBOutlet weak var Player2Symbol: UILabel!
    @IBOutlet weak var Player2Points: UILabel!
    
    @IBOutlet weak var actualRound: UILabel!
    
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
        
        gameModel.playerMakeMove(selectedPosition: position)
        
        sender.isUserInteractionEnabled = false
        sender.setTitle(ActualPlayerSymbol.text, for: .normal)
        
        updateUI()
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        if gameModel.actualRound >= gameModel.roundsNumber {
            showGameResultViewController()
            return
        }
        gameModel.newRound()
        clearButtons()
        communicates.text = ""
        sender.isHidden = true
        updateUI()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        showMenuViewController()
    }
}

extension UIViewController {
    func buttonIDtoPosition(id: String) -> (Int, Int) {
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
    
    func showGameResultViewController() {
        performSegue(withIdentifier: "showGameResultViewController", sender: self)
    }
    
    func showMenuViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuVC = storyboard.instantiateViewController(withIdentifier: "MenuViewController")
        
        menuVC.modalPresentationStyle = .fullScreen
        menuVC.modalTransitionStyle = .flipHorizontal
        
        present(menuVC, animated: true, completion: nil)
    }
}
