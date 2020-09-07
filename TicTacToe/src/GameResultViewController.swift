//
//  GameResultViewController.swift
//  TicTacToe
//
//  Created by Michał Nowak on 04/09/2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation
import UIKit

enum ResultFace {
    case loseFace
    case drawFace
    case winFace

    var image: UIImage {
        switch self {
            case .loseFace: return #imageLiteral(resourceName: "lose_face.png")
            case .drawFace: return #imageLiteral(resourceName: "draw_face.png")
            case .winFace: return #imageLiteral(resourceName: "win_face.png")
        }
    }
}

class GameResultViewController: UIViewController {
    var previousViewControllerID: String?
    var winner: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayGameResult()
    }
    
    private func displayGameResult() {
        if winner == nil {
            resultLabel.text = "Draw"
            resultImageView.image = ResultFace.drawFace.image
        }
        else {
            if winner!.name == "Player AI" {
                resultLabel.text = "You lose"
                resultImageView.image = ResultFace.loseFace.image
            }
            else {
                resultLabel.text = winner!.name + " is a winner"
                resultImageView.image = ResultFace.winFace.image
            }
        }
    }
    
    private func showPlayerVsPlayerViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let PlayerVsPlayerVC = storyboard.instantiateViewController(identifier: "PlayerVsPlayerVC")
        
        PlayerVsPlayerVC.modalPresentationStyle = .fullScreen
        PlayerVsPlayerVC.modalTransitionStyle = .flipHorizontal
        
        present(PlayerVsPlayerVC, animated: true, completion: nil)
    }
    
    private func showPlayerVsAiViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let PlayerVsAiVC = storyboard.instantiateViewController(identifier: "PlayerVsAiViewController")
        
        PlayerVsAiVC.modalPresentationStyle = .fullScreen
        PlayerVsAiVC.modalTransitionStyle = .flipHorizontal
        
        present(PlayerVsAiVC, animated: true, completion: nil)
    }
    
    // @IBOutlet's
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        switch previousViewControllerID {
        case "PlayerVsPlayerVC":
            showPlayerVsPlayerViewController()
            break
        case "PlayerVsAiViewController":
            showPlayerVsAiViewController()
            break
        default:
            break
        }
    }
    
    // @IBAction's
    @IBAction func backToMenuButtonPressed(_ sender: UIButton) {
        showMenuViewController()
    }
}
