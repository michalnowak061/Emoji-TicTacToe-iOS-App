//
//  PlayerVsPlayerSettingsSummaryVC.swift
//  TicTacToe
//
//  Created by Michał Nowak on 06/09/2020.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class PlayerVsPlayerSettingsSummaryVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            switch id {
            case "PlayerVsPlayerVCSegue":
                PlayerVsPlayerViewController.players = []
                PlayerVsPlayerViewController.players.append(Player(name: player1NameLabel.text!, symbol: PlayerSymbol.Circle))
                PlayerVsPlayerViewController.players.append(Player(name: player2NameLabel.text!, symbol: PlayerSymbol.Cross))
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
