//
//  Date_Extension.swift
//  XWLive
//
//  Created by 邱学伟 on 2016/12/23.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import Foundation
extension Data {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
