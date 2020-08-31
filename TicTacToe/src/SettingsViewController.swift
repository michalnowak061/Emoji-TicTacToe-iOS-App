//
//  SettingsViewController.swift
//  TicTacToe
//
//  Created by Michał Nowak on 31/08/2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    var settings: Settings!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settings = Settings()
        settings.load()
        
        updateUI()
    }
    
    private func updateUI() {
        difficultLevelLabel.text = settings.difficultLevelToString()
        
        switch difficultLevelLabel.text {
        case "easy":
            difficultLevelStepper.value = 0
        case "medium":
            difficultLevelStepper.value = 1
        case "hard":
            difficultLevelStepper.value = 2
        default:
            break
        }
    }
    
    @IBOutlet weak var difficultLevelLabel: UILabel!
    @IBOutlet weak var difficultLevelStepper: UIStepper!
    
    @IBAction func difficultLevelValueChanged(_ sender: UIStepper) {
        switch sender.value {
        case 0:
            settings.difficultLevel = GameDifficultLevel.easy.rawValue
        case 1:
            settings.difficultLevel = GameDifficultLevel.medium.rawValue
        case 2:
            settings.difficultLevel = GameDifficultLevel.hard.rawValue
        default:
            break
        }
        
        settings.save()
        updateUI()
    }
}
