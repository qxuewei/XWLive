//
//  XWTitleStyle.swift
//  XWPageViewDemo
//
//  Created by 邱学伟 on 2016/12/10.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit

class XWTitleStyle {
    /// 是否是滚动的Title
    var isScrollEnable : Bool = false
    /// 普通Title颜色
    var normalColor : UIColor = UIColor(R: 0, G: 0, B: 0)
    /// 选中Title颜色
    var selectedColor : UIColor = UIColor(R: 255, G: 127, B: 0)
    /// Title字体大小
    var font : UIFont = UIFont.systemFont(ofSize: 14.0)
    /// 滚动Title的字体间距
    var titleMargin : CGFloat = 20
    /// title的高度
    var titleHeight : CGFloat = 44
    
    
    
    /// 是否显示底部滚动条
    var isShowBottomLine : Bool = true
    /// 底部滚动条的颜色
    var bottomLineColor : UIColor = UIColor.orange
    /// 底部滚动条的高度
    var bottomLineH : CGFloat = 2
    
    
    /// 是否进行缩放
    var isNeedScale : Bool = false
    var scaleRange : CGFloat = 1.2
    
    
    /// 是否显示遮盖
    var isShowCover : Bool = false
    /// 遮盖背景颜色
    var coverBgColor : UIColor = UIColor.lightGray
    /// 文字&遮盖间隙
    var coverMargin : CGFloat = 5
    /// 遮盖的高度
    var coverH : CGFloat = 25
    /// 设置圆角大小
    var coverRadius : CGFloat = 12
}
