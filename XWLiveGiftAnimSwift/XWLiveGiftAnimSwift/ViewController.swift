//
//  ViewController.swift
//  XWLiveGiftAnimSwift
//
//  Created by 邱学伟 on 2017/3/31.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var digitLabel: XWGiftDigitLabel!
    
    fileprivate lazy var giftContainerView : XWGiftContainerView = XWGiftContainerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        giftContainerView.frame = CGRect(x: 0, y: 100, width: 250, height: 90)
        giftContainerView.backgroundColor = UIColor.lightGray
        view.addSubview(giftContainerView)

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        digitLabel.showDigitAnimation { 
            print("动画结束")
        }
    }
    @IBAction func gift1(_ sender: UIButton) {
        let giftModel : XWGiftModel = XWGiftModel(senderName: "发送人", senderURL: "icon4", giftName: "火箭", giftURL: "prop_b")
        giftContainerView.showGiftModel(giftModel)
        
    }
    @IBAction func gift2(_ sender: UIButton) {
        let giftModel2 : XWGiftModel = XWGiftModel(senderName: "发送人2", senderURL: "icon2", giftName: "飞机", giftURL: "prop_f")
        giftContainerView.showGiftModel(giftModel2)
    }
    @IBAction func gift3(_ sender: UIButton) {
        let giftModel3 : XWGiftModel = XWGiftModel(senderName: "发送人3", senderURL: "icon3", giftName: "跑车", giftURL: "prop_g")
        giftContainerView.showGiftModel(giftModel3)
    }


}

