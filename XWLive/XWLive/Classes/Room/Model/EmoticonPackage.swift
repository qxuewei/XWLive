//
//  EmoticonPackage.swift
//  XWLive
//
//  Created by 邱学伟 on 2017/1/5.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

class EmoticonPackage {
    lazy var emoticons : [Emoticon] = [Emoticon]()
    init(plistName : String) {
        guard let path = Bundle.main.path(forResource: plistName, ofType: nil) else {
            return
        }
        guard let emoticonArray = NSArray(contentsOfFile: path) else {
            return
        }
        for emoticonNameStr in emoticonArray {
            emoticons.append(Emoticon(emoticonName: emoticonNameStr as! String))
        }
    }
}
