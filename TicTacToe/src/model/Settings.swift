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

enum SettingsErrorCodes {
    case ok
    case saveError
    case loadError
}

struct Settings: Codable {
    var difficultLevel: Int = GameDifficultLevel.easy.rawValue
    var roundsNumber: Int = 1
    
    enum CodingKeys: String, CodingKey {
        case difficultLevel = "difficultLevel"
        case roundsNumber = "roundsNumber"
    }
    
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

extension Encodable {
    func saveEncodableToJSON(atPath: String) -> Bool {
        do {
            let encodedObject = try JSONEncoder().encode(self)
            
            if !FileManager.default.fileExists(atPath: atPath) {
                FileManager.default.createFile(atPath: atPath, contents: encodedObject, attributes: nil)
            }
            else {
                if let file = FileHandle(forWritingAtPath: atPath) {
                    file.write(encodedObject)
                }
            }
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
