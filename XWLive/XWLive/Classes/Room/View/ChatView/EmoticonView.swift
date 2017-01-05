//
//  EmoticonView.swift
//  XWLive
//
//  Created by 邱学伟 on 2017/1/4.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

private let kCollectionID : String = "kCollectionID"
private let kCollectionCellMargin : CGFloat = 10.0

class EmoticonView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmoticonView {
    fileprivate func setUpUI() {
        let style : XWTitleStyle = XWTitleStyle()
        style.isShowBottomLine = true
        let layout : XWPageCollectionLayout = XWPageCollectionLayout()
        layout.cols = 7
        layout.rows = 3
        layout.sectionInset = UIEdgeInsets(top: kCollectionCellMargin, left: kCollectionCellMargin, bottom: kCollectionCellMargin, right: kCollectionCellMargin)
        layout.minimumLineSpacing = kCollectionCellMargin
        layout.minimumInteritemSpacing = kCollectionCellMargin
        
        let pageCollection : XWPageCollectionView = XWPageCollectionView(frame: bounds, titles: ["普通","粉丝专属"], style: style, isTitleInTop: false, layout: layout)
        addSubview(pageCollection)
        pageCollection.dataSource = self
        pageCollection.register(nib: UINib(nibName: "EmoticonViewCell", bundle: nil), forCellWithReuseIdentifier: kCollectionID)
    }
}

extension EmoticonView : XWPageCollectionViewDataSource {
    func numberOfSections(in collectionView: XWPageCollectionView) -> Int {
        return EmoticonViewModel.shareInstance.packages.count
    }
    func collectionView(_ collectionView: XWPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        return EmoticonViewModel.shareInstance.packages[section].emoticons.count
    }
    func collectionView(_ pageCollection: XWPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : EmoticonViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionID, for: indexPath) as! EmoticonViewCell
        cell.emoticon = EmoticonViewModel.shareInstance.packages[indexPath.section].emoticons[indexPath.item]
        return cell
    }
}
