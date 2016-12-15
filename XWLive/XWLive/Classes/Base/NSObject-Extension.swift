//
//  NSObject-Extension.swift
//  XWLive
//
//  Created by 邱学伟 on 2016/12/15.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import Foundation

extension NSObject {
    func printProperty(_ obj : AnyClass) {
        var count : UInt32 = 0
        let ivars = class_copyIvarList(obj, &count)
        for i in 0..<count {
            guard let ivar = ivars?[Int(i)] else {
                return
            }
            guard let propertyName = ivar_getName(ivar) else {
                return
            }
            print(String(cString: propertyName))
        }
        free(ivars)
    }
}
