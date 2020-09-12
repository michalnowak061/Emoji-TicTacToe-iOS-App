//
//  AiPlayerSettingsVC.swift
//  TicTacToe
//
//  Created by Michał Nowak on 08/09/2020.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class AiPlayerSettingsVC: UIViewController {
    var emojiList: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEmojis()
        playerSymbolLabel.text = emojiList[0][0]
        playerSymbolCollectionView.delegate = self
        playerSymbolCollectionView.dataSource = self
        playerNameTextField.delegate = self
    }
    
    func fetchEmojis(){
        let emojiRanges = [
            0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x1F1E6...0x1F1FF, // Regional country flags
            0x2600...0x26FF,   // Misc symbols 9728 - 9983
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F,   // Variation Selectors
            0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
            0x1F018...0x1F270, // Various asian characters
            65024...65039,     // Variation selector
            9100...9300,       // Misc items
            8400...8447        // Combining Diacritical Marks for Symbols
        ]

        for range in emojiRanges {
            var array: [String] = []
            for i in range {
                if let unicodeScalar = UnicodeScalar(i){
                    array.append(String(describing: unicodeScalar))
                }
            }
            emojiList.append(array)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emojiList.count
    }
    
    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var playerSymbolLabel: UILabel!
    @IBOutlet weak var playerSymbolCollectionView: UICollectionView!
}

extension AiPlayerSettingsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playerSymbolLabel.text = emojiList[indexPath.section][indexPath.item]
    }
}

extension AiPlayerSettingsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}

extension AiPlayerSettingsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojiList[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCollectionViewCell", for: indexPath) as! EmojiCollectionViewCell
        cell.emojiLabel.text = emojiList[indexPath.section][indexPath.item]
        return cell
    }
}

