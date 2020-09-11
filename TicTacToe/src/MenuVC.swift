//
//  MenuVC.swift
//  TicTacToe
//
//  Created by Michał Nowak on 10/09/2020.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PvPButton.allowTextToScale()
        PvAiButton.allowTextToScale()
        SettingsButton.allowTextToScale()
    }
    
    @IBOutlet weak var PvPButton: UIButton!
    @IBOutlet weak var PvAiButton: UIButton!
    @IBOutlet weak var SettingsButton: UIButton!
}

extension UIButton {
    func allowTextToScale(minFontScale: CGFloat = 0.1, numberOfLines: Int = 1) {
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = minFontScale
        self.titleLabel?.lineBreakMode = .byTruncatingTail
        self.titleLabel?.numberOfLines = numberOfLines
    }
}
