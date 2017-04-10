//
//  XWGiftModel.swift
//  XWLiveGiftAnimSwift
//
//  Created by 邱学伟 on 2017/3/31.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

class XWGiftModel: NSObject {
    var senderName : String = ""
    var senderURL : String = ""
    var giftName : String = ""
    var giftURL : String = ""
    
    init(senderName : String, senderURL : String, giftName : String, giftURL : String) {
        self.senderName = senderName
        self.senderURL = senderURL
        self.giftName = giftName
        self.giftURL = giftURL
    }
    
//    override func isEqual(_ object: Any?) -> Bool {
//        guard let object = object as? XWGiftModel else {
//            return false
//        }
//        
//        guard object.giftName == giftName && object.senderName == senderName else {
//            return false
//        }
//        
//        return true
//    }

}
