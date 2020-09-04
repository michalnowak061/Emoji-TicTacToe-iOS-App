//
//  Settings.swift
//  TicTacToe
//
//  Created by Michał Nowak on 31/08/2020.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

enum GameDifficultLevel: Int {
    case easy = 2
    case medium = 3
    case hard = 5
}

enum SettingsErrorCodes {
    case ok
    case saveError
    case loadError
}

struct Settings: Codable {
    var difficultLevel: Int = GameDifficultLevel.easy.rawValue
    var roundsNumber: Int = 1
    
    mutating func load() -> SettingsErrorCodes {
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let settingsFilePath = documentsDirectoryPathString + "/Settings.json"
        if !loadDecodableFromJSON(fromPath: settingsFilePath) {
            return SettingsErrorCodes.loadError
        }
        return SettingsErrorCodes.ok
    }
    
    func save() -> SettingsErrorCodes {
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let settingsFilePath = documentsDirectoryPathString + "/Settings.json"
        if !saveEncodableToJSON(atPath: settingsFilePath) {
            return SettingsErrorCodes.saveError
        }
        return SettingsErrorCodes.ok
    }
    
    func difficultLevelToString() -> String {
        switch difficultLevel {
        case GameDifficultLevel.easy.rawValue:
            return "easy"
        case GameDifficultLevel.medium.rawValue:
            return "medium"
        case GameDifficultLevel.hard.rawValue:
            return "hard"
        default:
            return "easy"
        }
    }
}

extension Encodable {
    func saveEncodableToJSON(atPath: String) -> Bool {
        do {
            let encodedObject = try JSONEncoder().encode(self)
            FileManager.default.createFile(atPath: atPath, contents: encodedObject, attributes: nil)
            return true
        }
        catch {
            return false
        }
    }
}

extension Decodable {
    mutating func loadDecodableFromJSON(fromPath: String) -> Bool {
        if FileManager.default.fileExists(atPath: fromPath) {
            do {
                let file = FileHandle(forReadingAtPath: fromPath)
                let data = file!.readDataToEndOfFile()
                let settingsDecoded = try JSONDecoder().decode(Settings.self, from: data)
                self = settingsDecoded as! Self
                return true
            }
            catch {
                return false
            }
        } else {
            return false
        }
    }
}
