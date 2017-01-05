//
//  XWPageCollectionLayout.swift
//  XWPageViewDemo
//
//  Created by 邱学伟 on 2017/1/3.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

class XWPageCollectionLayout: UICollectionViewFlowLayout {
    var cols : Int = 4
    var rows : Int = 2
    fileprivate lazy var cellAttris : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var maxWidth : CGFloat = 0
}

/// 准备布局方式
extension XWPageCollectionLayout {
    override func prepare() {
        super.prepare()
        guard let sectionsCount : Int = collectionView?.numberOfSections else {
            return
        }
        // 计算item宽高
        let itemW : CGFloat = ((collectionView?.bounds.width)! - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(cols - 1)) / CGFloat(cols)
        let itemH : CGFloat = ((collectionView?.bounds.height)! - sectionInset.top - sectionInset.bottom - minimumLineSpacing * CGFloat(rows - 1)) / CGFloat(rows)
        
        // 一共累计有多少页
        var pageCount : Int = 0
        for i in 0..<sectionsCount {
            guard let itemsCount : Int = collectionView?.numberOfItems(inSection: i) else {
                return
            }
            for j in 0..<itemsCount {
                let indexPath : IndexPath = IndexPath(item: j, section: i)
                let cellAttri : UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                //当前item 在该组中处于第几页
                let page : Int = j / (cols * rows)
                let index : Int = j % (cols * rows)
                
                let itemX : CGFloat = sectionInset.left + CGFloat(index % cols) * (itemW + minimumInteritemSpacing) + CGFloat(pageCount + page) * collectionView!.bounds.width
                let itemY : CGFloat = sectionInset.top + (itemH + minimumLineSpacing) * CGFloat(index / cols)
                cellAttri.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                cellAttris.append(cellAttri)
            }
            pageCount += (itemsCount - 1) / (cols * rows) + 1
        }
        //计算最大X值
        maxWidth = CGFloat(pageCount) * collectionView!.bounds.width
    }
}

/// 返回准备好的布局
extension XWPageCollectionLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttris
    }
}


/// 计算ContenSize
extension XWPageCollectionLayout {
    override var collectionViewContentSize: CGSize {
        return CGSize(width: maxWidth, height: 0)
    }
}
