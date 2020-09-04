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
    var settingsErrorCode: SettingsErrorCodes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settings = Settings()
        settingsErrorCode = settings.load()
        updateUI()
    }
    
    private func updateUI() {
        difficultLevelLabel.text = settings.difficultLevelToString()
        switch settings.difficultLevel {
        case GameDifficultLevel.easy.rawValue:
            difficultLevelStepper.value = 0
        case GameDifficultLevel.medium.rawValue:
            difficultLevelStepper.value = 1
        case GameDifficultLevel.hard.rawValue:
            difficultLevelStepper.value = 2
        default:
            break
        }
        
        roundsNumberLabel.text = String(settings.roundsNumber)
        roundsNumberStepper.value = Double(settings.roundsNumber)
        
        switch settingsErrorCode {
        case SettingsErrorCodes.ok?:
            print("SettingsViewController: ok")
            break
        case SettingsErrorCodes.loadError?:
            print("SettingsViewController: loadError")
            break
        case SettingsErrorCodes.saveError?:
            print("SettingsViewController: saveError")
            break
        default:
            break
        }
    }
    
    @IBOutlet weak var difficultLevelLabel: UILabel!
    @IBOutlet weak var difficultLevelStepper: UIStepper!
    
    @IBOutlet weak var roundsNumberLabel: UILabel!
    @IBOutlet weak var roundsNumberStepper: UIStepper!
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
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
        settingsErrorCode = settings.save()
        updateUI()
    }
    
    @IBAction func roundsNumberValueChanged(_ sender: UIStepper) {
        settings.roundsNumber = Int(sender.value)
        settingsErrorCode = settings.save()
        updateUI()
    }
}
