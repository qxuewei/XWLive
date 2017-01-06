//
//  GiftViewCell.swift
//  XWLive
//
//  Created by 邱学伟 on 2017/1/5.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

class GiftViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    lazy var cellSelectedBackgroundView: UIView = {
        let cellSelectedBackgroundView : UIView = UIView()
        cellSelectedBackgroundView.layer.cornerRadius = 5
        cellSelectedBackgroundView.layer.masksToBounds = true
        cellSelectedBackgroundView.layer.borderWidth = 1
        cellSelectedBackgroundView.layer.borderColor = UIColor.orange.cgColor
        cellSelectedBackgroundView.backgroundColor = UIColor.black
        return cellSelectedBackgroundView
    }()
    
    var giftModel : GiftModel? {
        didSet{
            priceLabel.text = "\(giftModel?.coin ?? 0)"
            let imageURL : URL = URL(string: (giftModel?.img2)!)!
            self.iconImageView.kf.setImage(with: imageURL,placeholder:UIImage(named: "room_btn_gift"))
            subjectLabel.text = giftModel?.subject
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = cellSelectedBackgroundView
    }
}
