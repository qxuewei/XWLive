//
//  HomeViewController.swift
//  XWLive
//
//  Created by 邱学伟 on 2016/12/15.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

extension HomeViewController {
    fileprivate func setUpUI() {
        setUpNavigationBar()
    }
    private func setUpNavigationBar() {
        let logoImage = UIImage(named: "home-logo")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoImage, style: .plain, target: nil, action: nil)
        let collectImage = UIImage(named: "search_btn_follow")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: collectImage, style: .plain, target: self, action: #selector(followItemClick))
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 32))
        searchBar.placeholder = "主播昵称/房间号/链接"
        searchBar.searchBarStyle = .minimal
        guard let _searchField = searchBar.value(forKey: "_searchField") as? UITextField else {
            return
        }
        _searchField.textColor = UIColor.white
        navigationItem.titleView = searchBar
    }
}

extension HomeViewController {
    @objc fileprivate func followItemClick() {
        print("++++")
    }
}
