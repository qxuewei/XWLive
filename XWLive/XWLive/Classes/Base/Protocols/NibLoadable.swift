//
//  NibLoadable.swift
//  XWLive
//
//  Created by 邱学伟 on 2017/1/4.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import Foundation
import UIKit

protocol Nibloadable {
    
}
extension Nibloadable where Self : UIView {
    static func loadViewFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)!.last as! Self
    }
}
