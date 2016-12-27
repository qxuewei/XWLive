//
//  BaseModel.swift
//  XWLive
//
//  Created by 邱学伟 on 2016/12/23.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    override init() {
        
    }
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
