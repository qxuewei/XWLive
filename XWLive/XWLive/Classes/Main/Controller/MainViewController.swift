//
//  MainViewController.swift
//  XWLive
//
//  Created by 邱学伟 on 2016/12/15.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC("Home")
        addChildVC("Discover")
        addChildVC("Profile")
        addChildVC("Rank")
    }
    
}

extension MainViewController {
    fileprivate func addChildVC(_ childStoryBoardName : String) {
        guard let childVC  = UIStoryboard(name: childStoryBoardName, bundle: nil).instantiateInitialViewController() else{
            return
        }
        addChildViewController(childVC)
    }
}
