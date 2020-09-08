//
//  PlayerVsAiSettingsSummaryVC.swift
//  TicTacToe
//
//  Created by Michał Nowak on 08/09/2020.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class PlayerVsAiSettingsSummaryVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            switch id {
            case "PlayerVsAiVCSegue":
                PlayerVsAiViewController.players = []
                PlayerVsAiViewController.players.append(Player(name: player1NameLabel.text!, symbol: player1Symbol.text!))
                PlayerVsAiViewController.players.append(Player(name: player2NameLabel.text!, symbol: player2Symbol.text!))
            default:
                break
            }
        }
    }
    
    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player1Symbol: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var player2Symbol: UILabel!
}
