//
//  NibLoadable.swift
//  XWLive
//
//  Created by 邱学伟 on 2017/1/4.
//  Copyright © 2017年 邱学伟. All rights reserved.
//  View可在xib中加载协议

import Foundation
import UIKit

protocol Nibloadable {
    
}
extension Nibloadable where Self : UIView {
    static func loadViewFromNib(_ nibName : String?) -> Self {
        let loadNibName = nibName == nil ? "\(self)" : nibName
        guard let loadNibs = Bundle.main.loadNibNamed(loadNibName!, owner: nil, options: nil) else {
            print("未在xib中定义!")
            return UIView() as! Self
        }
        return loadNibs.last as! Self
    }
    static func loadViewFromNib() -> Self {
        guard let loadNibs = Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil) else {
            print("未在xib中定义!")
            return UIView() as! Self
        }
        return loadNibs.last as! Self
    }
}
