//
//  AnchorViewController.swift
//  XWLive
//
//  Created by 邱学伟 on 2016/12/23.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 8.0
private let kAnchorCellID = "kAnchorCellID"

class AnchorViewController: UIViewController {
    var homeType = HomeType()
    
    fileprivate lazy var homeVM : HomeViewModel = HomeViewModel()
    fileprivate lazy var collection : UICollectionView = {
       let layout = XWWaterFallLayout()
        layout.sectionInset = UIEdgeInsets(top: kEdgeMargin, left: kEdgeMargin, bottom: kEdgeMargin, right: kEdgeMargin)
        layout.minimumLineSpacing = kEdgeMargin
        layout.minimumInteritemSpacing = kEdgeMargin
        layout.dataSource = self

        let collection : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: kAnchorCellID)
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.backgroundColor = UIColor.white
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        loadData(index: 0)
    }
}

extension AnchorViewController {
    fileprivate func setUpUI() {
        view.addSubview(collection)
    }
}

extension AnchorViewController {
    fileprivate func loadData(index : Int) {
        homeVM.loadHomeData(type: homeType, index: index, finishedCallback: {
            self.collection.reloadData()
        })
    }
}

extension AnchorViewController :XWWaterFallLayoutDataSource,UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVM.anchorModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAnchorCellID, for: indexPath) as! HomeViewCell
        cell.anchorModel = homeVM.anchorModels[indexPath.item]
        if indexPath.item == homeVM.anchorModels.count - 1 {
            loadData(index: homeVM.anchorModels.count)
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let roomVc = RoomViewController()
        navigationController?.pushViewController(roomVc, animated: true)
    }
    func numberOfCols(_waterFallLayout: XWWaterFallLayout) -> Int {
        return 2
    }
    func itemHeight(_waterFallLayout: XWWaterFallLayout, item: Int) -> CGFloat {
        return item % 2 == 0 ? kScreenW * 2 / 3 : kScreenW * 0.5
    }
    
}
