//
//  EmoticonViewCell.swift
//  XWLive
//
//  Created by 邱学伟 on 2017/1/4.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

class EmoticonViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    var emoticon : Emoticon? {
        didSet {
            guard let image = UIImage(named: (emoticon?.emoticonName)!) else { return }
            iconImageView.image = image// UIImage(named: emoticon!.emoticonName)
        }
    }
}
