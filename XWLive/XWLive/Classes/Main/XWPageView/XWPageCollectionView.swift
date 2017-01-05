//
//  XWPageCollectionView.swift
//  XWPageViewDemo
//
//  Created by 邱学伟 on 2017/1/3.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

protocol XWPageCollectionViewDataSource : class {
    func numberOfSections(in collectionView: XWPageCollectionView) -> Int
    func collectionView(_ collectionView: XWPageCollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ pageCollection : XWPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

class XWPageCollectionView: UIView {
    
    weak var dataSource : XWPageCollectionViewDataSource?
    
    fileprivate var isTitleInTop : Bool
    fileprivate var style : XWTitleStyle
    fileprivate var titles : [String]
    fileprivate var layout : XWPageCollectionLayout
    fileprivate var titleView : XWTitleView!
    fileprivate var collectionView : UICollectionView!
    fileprivate var pageControl : UIPageControl!
    fileprivate var currentIndexPath : IndexPath = IndexPath(item: 0, section: 0)
    
    init(frame: CGRect, titles : [String], style : XWTitleStyle, isTitleInTop : Bool, layout : XWPageCollectionLayout) {
        self.isTitleInTop = isTitleInTop
        self.style = style
        self.titles = titles
        self.layout = layout
//        parentVC.automaticallyAdjustsScrollViewInsets = false
        super.init(frame: frame)
        setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XWPageCollectionView {
    func register(cellClass: AnyClass?, forCellWithReuseIdentifier: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: forCellWithReuseIdentifier)
    }
    func register(nib: UINib?, forCellWithReuseIdentifier: String) {
        collectionView.register(nib, forCellWithReuseIdentifier: forCellWithReuseIdentifier)
    }
}

extension XWPageCollectionView {
    fileprivate func setUpUI() {
        //创建TitleView
        let titleY = isTitleInTop ? 0 : bounds.height - style.titleHeight
        let titleViewFrame = CGRect(x: 0, y: titleY, width: bounds.width, height: style.titleHeight)
        titleView = XWTitleView(frame: titleViewFrame, titles: titles, style: style)
        titleView.delegate = self
        addSubview(titleView)

        //创建UIPageControl
        let pageControlH : CGFloat = 20
        let pageControlY : CGFloat = isTitleInTop ? (bounds.height - pageControlH) : (bounds.height - pageControlH - style.titleHeight)
        pageControl = UIPageControl(frame: CGRect(x: 0, y: pageControlY, width: bounds.width, height: pageControlH))
        pageControl.isEnabled = false
        pageControl.numberOfPages = 4
        addSubview(pageControl)
        pageControl.backgroundColor = UIColor.getRandomColor()
        
        //创建UICollectionView
        let collectionViewY = isTitleInTop ? style.titleHeight : 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: collectionViewY, width: bounds.width, height: bounds.height - pageControlH - style.titleHeight), collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
    }
}

extension XWPageCollectionView : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSections(in: self) ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemCount : Int = dataSource?.collectionView(self, numberOfItemsInSection: section) ?? 0
        if section == 0 {
            pageControl.numberOfPages = (itemCount - 1) / (layout.rows * layout.cols) + 1
        }
        return itemCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (dataSource?.collectionView(self, collectionView, cellForItemAt: indexPath))!
    }
}

extension XWPageCollectionView : UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewEndScroll()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewEndScroll()
        }
    }
    private func scrollViewEndScroll() {
        let point : CGPoint = CGPoint(x: collectionView.contentOffset.x + layout.sectionInset.left + 1, y: layout.sectionInset.top + 1)
        guard let indexPathInPage : IndexPath = collectionView.indexPathForItem(at: point) else {return}
        if currentIndexPath.section != indexPathInPage.section {
            guard let itemCount : Int = dataSource?.collectionView(self, numberOfItemsInSection: indexPathInPage.section) else { return }
            pageControl.numberOfPages = (itemCount - 1) / (layout.rows * layout.cols) + 1
            titleView.setTitleWithProgress(1.0, sourceIndex: currentIndexPath.section, targetIndex: indexPathInPage.section)
            currentIndexPath = indexPathInPage
        }
        pageControl.currentPage = indexPathInPage.item / (layout.cols * layout.rows)
    }
}

extension XWPageCollectionView : XWTitleViewDelegate {
    func titleView(_ titleView: XWTitleView, selectedIndex index: Int) {
        let indexpath = IndexPath(item: 0, section: index)
//        collectionView.scrollToItem(at: indexpath, at: .top, animated: false) //如果左对齐需要注意偏移量的bug
        collectionView.scrollToItem(at: indexpath, at: .left, animated: false)
        collectionView.contentOffset.x -= layout.sectionInset.left
        guard let itemCount = dataSource?.collectionView(self, numberOfItemsInSection: indexpath.section) else {
            return
        }
        pageControl.numberOfPages = (itemCount - 1) / (layout.rows * layout.cols) + 1
        pageControl.currentPage = 0
    }
}
