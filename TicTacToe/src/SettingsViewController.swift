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
        
        roundsNumberLabel.text = String(settings.roundsNumber)
        roundsNumberStepper.value = Double(settings.roundsNumber)
        
        switch settingsErrorCode {
        case SettingsErrorCodes.loadError?:
            print("SettingsViewController: SettingsErrorCodes.loadError")
            break
        case SettingsErrorCodes.saveError?:
            print("SettingsViewController: SettingsErrorCodes.saveError")
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
        dismiss(animated: true, completion: {
            self.settingsErrorCode = self.settings.save()
        })
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
