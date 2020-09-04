//
//  GameResultViewController.swift
//  TicTacToe
//
//  Created by Michał Nowak on 04/09/2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation
import UIKit

class GameResultViewController: UIViewController {
    var previousViewControllerID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func showPlayerVsPlayerViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let PlayerVsPlayerVC = storyboard.instantiateViewController(identifier: "PlayerVsPlayerViewController")
        
        PlayerVsPlayerVC.modalPresentationStyle = .fullScreen
        PlayerVsPlayerVC.modalTransitionStyle = .flipHorizontal
        
        present(PlayerVsPlayerVC, animated: true, completion: nil)
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        switch previousViewControllerID {
        case "PlayerVsPlayerViewController":
            showPlayerVsPlayerViewController()
            break
        default:
            break
        }
    }
    
    @IBAction func backToMenuButtonPressed(_ sender: UIButton) {
        showMenuViewController()
    }
}
