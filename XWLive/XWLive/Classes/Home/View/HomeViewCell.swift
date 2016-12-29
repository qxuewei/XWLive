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
            
            let resource : String = (anchorModel!.isEvenIndex ? anchorModel?.pic74 : anchorModel?.pic51)!
            let url = URL(string: resource)
            albumImageView.kf.setImage(with: url,placeholder: Image(named: "home_pic_default"))
            liveImageView.isHidden = anchorModel?.live == 0
            nickNameLabel.text = anchorModel?.name
            onlinePeopleLabel.setTitle("\(anchorModel?.focus ?? 0)", for: .normal)
        }
    }
    
}
