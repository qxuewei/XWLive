//
//  HomeViewCell.swift
//  XWLive
//
//  Created by 邱学伟 on 2016/12/28.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewCell: UICollectionViewCell {

    // MARK: 控件属性
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var liveImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlinePeopleLabel: UIButton!
    
    // MARK: 定义属性
    var anchorModel : AnchorModel? {
        didSet {
            guard let isEvenIndex = anchorModel?.isEvenIndex else {
                return
            }
            guard let pic74 = anchorModel?.pic74 else {
                return
            }
            guard let pic51 = anchorModel?.pic51 else {
                return
            }
            albumImageView.kf.setImage(with: (isEvenIndex ? pic74 : pic51) as? Resource, placeholder: Image(named: "home_pic_default"), options: nil, progressBlock: nil, completionHandler: nil)
            liveImageView.isHidden = anchorModel?.live == 0
            nickNameLabel.text = anchorModel?.name
            onlinePeopleLabel.setTitle("\(anchorModel?.focus ?? 0)", for: .normal)
        }
    }
    
}
