//
//  Settings.swift
//  TicTacToe
//
//  Created by Michał Nowak on 31/08/2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

enum GameDifficultLevel: Int {
    case easy = 0
    case medium = 2
    case hard = 5
}

struct Settings: Codable {
    var difficultLevel: Int = GameDifficultLevel.easy.rawValue
    
    enum CodingKeys: String, CodingKey {
        case difficultLevel = "difficultLevel"
    }
    
    mutating func load() {
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let settingsFilePath = documentsDirectoryPathString + "/Settings.json"
        
        if FileManager.default.fileExists(atPath: settingsFilePath) {
            if let file = FileHandle(forReadingAtPath: settingsFilePath) {
                let data = file.readDataToEndOfFile()
                
                let settingsDecoded = try! JSONDecoder().decode(Settings.self, from: data)
                self = settingsDecoded
            }
        }
    }
    
    func save() {
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let settingsFilePath = documentsDirectoryPathString + "/Settings.json"
        let settingsEncoded = try? JSONEncoder().encode(self)
        
        if !FileManager.default.fileExists(atPath: settingsFilePath) {
            FileManager.default.createFile(atPath: settingsFilePath, contents: settingsEncoded, attributes: nil)
        }
        else {
            if let file = FileHandle(forWritingAtPath: settingsFilePath) {
                file.write(settingsEncoded!)
            }
        }
    }
    
    func difficultLevelToString() -> String {
        switch difficultLevel {
        case 0:
            return "easy"
        case 2:
            return "medium"
        case 5:
            return "hard"
        default:
            return "easy"
        }
    }
}
