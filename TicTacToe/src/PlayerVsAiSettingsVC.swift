//
//  PlayerVsAiSettingsVC.swift
//  TicTacToe
//
//  Created by Michał Nowak on 08/09/2020.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class PlayerVsAiSettingsVC: UIViewController {
    var subViewControllers: [UIViewController] = [
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayerSettingsVC") as! PlayerSettingsVC,
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AiPlayerSettingsVC") as! AiPlayerSettingsVC,
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayerVsAiSettingsSummaryVC") as! PlayerVsAiSettingsSummaryVC
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSubViews()
        pageControll.numberOfPages = subViewControllers.count
        scrollView.delegate = self
    }
    
    private func loadSubViews() {
        var frame = CGRect.zero
        for index in 0..<subViewControllers.count {
            let subView = subViewControllers[index]
            
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            subView.view.frame = frame

            subView.willMove(toParent: self)
            addChild(subView)
            subView.didMove(toParent: self)
            scrollView.addSubview(subView.view)
        }
        
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(subViewControllers.count)), height: scrollView.frame.size.height)
    }
    
    private func updateSubViews() {
        let firstSubView = subViewControllers[0] as! PlayerSettingsVC
        let secondSubView = subViewControllers[1] as! AiPlayerSettingsVC
        let thirdSubView = subViewControllers[2] as! PlayerVsAiSettingsSummaryVC
        thirdSubView.player1NameLabel.text = firstSubView.playerNameTextField.text
        thirdSubView.player1Symbol.text = firstSubView.playerSymbolLabel.text
        thirdSubView.player2NameLabel.text = secondSubView.playerNameTextField.text
        thirdSubView.player2Symbol.text = secondSubView.playerSymbolLabel.text
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        showMenuViewController()
    }
}

extension PlayerVsAiSettingsVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControll.currentPage = Int(pageNumber)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        updateSubViews()
    }
}

