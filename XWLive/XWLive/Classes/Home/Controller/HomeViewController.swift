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
        setUpContentView()
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
    private func setUpContentView() {
        let homeTypes = loadTypesData()
        let style = XWTitleStyle()
        style.isScrollEnable = true
        let pageFrame = CGRect(x: 0, y: kNavigationBarH + kStatusBarH, width: kScreenW, height: kScreenH - kNavigationBarH - kStatusBarH - 44)
        //取出数组中所有标题数据
        /*
        var titles = [String]()
        for type in homeTypes {
            titles.append(type.title)
        }
        //等价于
        let titless = homeTypes.map { (type : HomeType) -> String in
            return type.title
        }
        //等价于
        let titlesss = homeTypes.map({ $0.title })
        */
        let fileterS = homeTypes.filter({ $0.title == "全部" })
        print("fileterS: HomeVC ++++56 \(fileterS)")
        
        let titles = homeTypes.map({ $0.title })
        var childVCs = [AnchorViewController]()
        for homeType in homeTypes {
            let anchorVC = AnchorViewController()
            anchorVC.homeType = homeType
            anchorVC.view.backgroundColor = UIColor.getRandomColor()
            childVCs.append(anchorVC)
        }
        let pageView : XWPageView = XWPageView(frame: pageFrame, titles: titles, style: style, childVcs: childVCs, parentVc: self)
        view.addSubview(pageView)
    }
    private func loadTypesData() -> [HomeType] {
        let path = Bundle.main.path(forResource: "types.plist", ofType: nil)
        let dataArray = NSArray(contentsOfFile: path!) as! [[String : Any]]
        var homeTypeArrM = [HomeType]()
        for dict in dataArray {
            homeTypeArrM.append(HomeType(dict: dict))
        }
        return homeTypeArrM
    }
}

extension HomeViewController {
    @objc fileprivate func followItemClick() {
        print("++++")
    }
}
