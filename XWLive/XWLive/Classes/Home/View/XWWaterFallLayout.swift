//
//  XWWaterFallLayout.swift
//  XWWaterFallSwiftDemo
//
//  Created by 邱学伟 on 2016/12/6.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit

//MARK: - 数据源协议
protocol XWWaterFallLayoutDataSource : class {
    ///每行个数
    func numberOfCols(_waterFallLayout : XWWaterFallLayout) -> Int
    ///item 高度
    func itemHeight(_waterFallLayout : XWWaterFallLayout, item : Int) -> CGFloat
}

class XWWaterFallLayout: UICollectionViewFlowLayout {
    weak var dataSource : XWWaterFallLayoutDataSource?
    fileprivate lazy var cellAttributes : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var cols : Int = {
        return self.dataSource?.numberOfCols(_waterFallLayout: self) ?? 2
    }()
    fileprivate lazy var totalHeight : [CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols)
    fileprivate var maxH : CGFloat = 0
    fileprivate var startIndex = 0
}

//MARK: - 准备布局
extension XWWaterFallLayout {
    override func prepare() {
        super.prepare()
        
        let itemCount : Int = collectionView!.numberOfItems(inSection: 0)
        //为每个cell创建 UICollectionViewLayoutAttributes(决定cell位置)
        let width : CGFloat = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - CGFloat(cols - 1) * minimumInteritemSpacing) / CGFloat(cols)
        for i in startIndex..<itemCount {
            let indexPath : IndexPath = IndexPath(item: i, section: 0)
            let attributes : UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            let minH : CGFloat = totalHeight.min()!
            let minIndex = totalHeight.index(of: minH)!
            let X : CGFloat = sectionInset.left + (minimumInteritemSpacing + width) * CGFloat(minIndex)
            let Y : CGFloat = minH + minimumLineSpacing
            guard let height : CGFloat = dataSource?.itemHeight(_waterFallLayout: self, item: i) else {
                fatalError("请遵守数据源实现对应方法返回cell高度")
            }
            attributes.frame = CGRect(x: X, y: Y, width: width, height: height)
            cellAttributes.append(attributes)
            totalHeight[minIndex] = minH + minimumLineSpacing + height
        }
        maxH = totalHeight.max()!
        startIndex = itemCount
    }
}

//MARK: - 返回布局
extension XWWaterFallLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttributes
    }
}

//MARK: - 设置ContentSize
extension XWWaterFallLayout {
    override var collectionViewContentSize: CGSize{
        return CGSize(width: 0, height: maxH + sectionInset.bottom - minimumLineSpacing)
    }
}
