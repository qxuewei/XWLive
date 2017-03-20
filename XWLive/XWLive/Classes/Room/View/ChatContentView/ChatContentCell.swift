//
//  ChatContentCell.swift
//  XWLive
//
//  Created by 邱学伟 on 2017/3/20.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

class ChatContentCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clear
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        contentLabel.textColor = UIColor.white
        selectionStyle = .none
        contentView.backgroundColor = UIColor.clear
    }
}
