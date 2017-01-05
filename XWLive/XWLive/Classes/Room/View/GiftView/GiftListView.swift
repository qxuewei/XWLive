//
//  GiftListView.swift
//  XWLive
//
//  Created by 邱学伟 on 2017/1/5.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit
fileprivate let kPageCollectionCellMargin : CGFloat = 10.0
fileprivate let kPageCollectionCellID : String = "kPageCollectionCellID"
class GiftListView: UIView, Nibloadable {
    // MARK: 控件属性
    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var sendGiftBtn: UIButton!
    
    fileprivate var pageCollectionView : XWPageCollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGiftView()
    }
    private func setupGiftView() {
        let titles : [String] = ["热门", "高级", "豪华", "专属"]
        
        let style : XWTitleStyle = XWTitleStyle()
        style.normalColor = UIColor(R: 255, G: 255, B: 255)

        let layout : XWPageCollectionLayout = XWPageCollectionLayout()
        layout.sectionInset = UIEdgeInsets(top: kPageCollectionCellMargin, left: kPageCollectionCellMargin, bottom: kPageCollectionCellMargin, right: kPageCollectionCellMargin)
        layout.minimumLineSpacing = kPageCollectionCellMargin
        layout.minimumInteritemSpacing = kPageCollectionCellMargin
        layout.cols = 4
        layout.rows = 2
        
        pageCollectionView = XWPageCollectionView(frame: giftView.bounds, titles: titles, style: style, isTitleInTop: true, layout: layout)
        pageCollectionView.backgroundColor = UIColor.lightGray
        giftView.addSubview(pageCollectionView)
        
        pageCollectionView.dataSource = self
        pageCollectionView.register(cellClass: UICollectionViewCell.self, forCellWithReuseIdentifier: kPageCollectionCellID)
    }
}

extension GiftListView : XWPageCollectionViewDataSource {
    func numberOfSections(in collectionView: XWPageCollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: XWPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ pageCollection: XWPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPageCollectionCellID, for: indexPath)
        cell.backgroundColor = UIColor.getRandomColor()
        return cell
    }
}
