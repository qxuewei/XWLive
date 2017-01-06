//
//  GiftListView.swift
//  XWLive
//
//  Created by 邱学伟 on 2017/1/5.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

protocol GiftListViewDelegate : class {
    func giftListView(_ giftListView : GiftListView, giftModel : GiftModel)
}

fileprivate let kPageCollectionCellMargin : CGFloat = 10.0
fileprivate let kPageCollectionCellID : String = "kPageCollectionCellID"
class GiftListView: UIView, Nibloadable {
    
    weak var delegate : GiftListViewDelegate?
    
    // MARK: 控件属性
    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var sendGiftBtn: UIButton!
    
    fileprivate var pageCollectionView : XWPageCollectionView!
    fileprivate var giftViewModel : GiftViewModel = GiftViewModel()
    fileprivate var currentIndexPath : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGiftView()
        loadGiftData()
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
        var giftViewFrame : CGRect = giftView.bounds
        giftViewFrame.size.width = kScreenW
        pageCollectionView = XWPageCollectionView(frame: giftViewFrame, titles: titles, style: style, isTitleInTop: true, layout: layout)
        pageCollectionView.backgroundColor = UIColor.lightGray
        giftView.addSubview(pageCollectionView)
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        pageCollectionView.register(nib: UINib(nibName: "GiftViewCell", bundle: nil), forCellWithReuseIdentifier: kPageCollectionCellID)
    }
}

/// 网络请求数据
extension GiftListView {
    fileprivate func loadGiftData() {
        giftViewModel.loadGiftData {
            self.pageCollectionView.reloadData()
        }
    }
}

extension GiftListView : XWPageCollectionViewDataSource,XWPageCollectionViewDelegate {
    func numberOfSections(in collectionView: XWPageCollectionView) -> Int {
        return giftViewModel.giftlistData.count
    }
    func collectionView(_ collectionView: XWPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        let package = giftViewModel.giftlistData[section]
        return package.list.count
    }
    func collectionView(_ pageCollection: XWPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPageCollectionCellID, for: indexPath) as! GiftViewCell
        let package = giftViewModel.giftlistData[indexPath.section]
        let giftModel : GiftModel = package.list[indexPath.item]
        cell.giftModel = giftModel
        return cell
    }
    func collectionView(_ collectionView: XWPageCollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndexPath = indexPath
        sendGiftBtn.isEnabled = true
    }
}

// MARK:- 送礼物
extension GiftListView {
    @IBAction func sendGiftBtnClick() {
        guard let currentIndexPath = currentIndexPath else {
            sendGiftBtn.isEnabled = false
            return
        }
        let package : GiftPackage = giftViewModel.giftlistData[currentIndexPath.section]
        let giftModel : GiftModel = package.list[currentIndexPath.item]
        delegate?.giftListView(self, giftModel: giftModel) 
    }
}
