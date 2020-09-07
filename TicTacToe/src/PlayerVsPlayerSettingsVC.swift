//
//  PlayerVsPlayerSettingsVC.swift
//  TicTacToe
//
//  Created by Michał Nowak on 06/09/2020.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class PlayerVsPlayerSettingsVC: UIViewController {
    var subViewControllers: [UIViewController] = [
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstPlayerSettingsVC") as! FirstPlayerSettingsVC,
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondPlayerSettingsVC") as! SecondPlayerSettingsVC,
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayerVsPlayerSettingsSummaryVC") as! PlayerVsPlayerSettingsSummaryVC
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
        let firstSubView = subViewControllers[0] as! FirstPlayerSettingsVC
        let secondSubView = subViewControllers[1] as! SecondPlayerSettingsVC
        let thirdSubView = subViewControllers[2] as! PlayerVsPlayerSettingsSummaryVC
        thirdSubView.player1NameLabel.text = firstSubView.playerNameTextField.text
        thirdSubView.player2NameLabel.text = secondSubView.playerNameTextField.text
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
}

extension PlayerVsPlayerSettingsVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControll.currentPage = Int(pageNumber)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        updateSubViews()
    }
}
