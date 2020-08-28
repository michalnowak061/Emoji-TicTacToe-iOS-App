//
//  Player.swift
//  TicTacToe
//
//  Created by Michał Nowak on 27/08/2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

enum Symbol: Int {
    case Null
    case Circle
    case Cross
}

struct Player {
    var name: String
    var symbol: Symbol
    var points = 0
    
    init(name: String, symbol: Symbol) {
        self.name = name
        self.symbol = symbol
    }
}
