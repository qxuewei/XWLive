//
//  GiftModel.swift
//  XWLive
//
//  Created by 邱学伟 on 2017/1/5.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

class GiftModel {
    var img2 : String = "" // 图片
    var coin : Int = 0 // 价格
    var subject : String = "" { // 标题
        didSet {
            if subject.contains("(有声)") {
                subject = subject.replacingOccurrences(of: "(有声)", with: "")
            }
        }
    }
}
