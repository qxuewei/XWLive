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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        digitLabel.showDigitAnimation { 
            print("动画结束")
        }
    }
    @IBAction func gift1(_ sender: UIButton) {
        let giftModel : XWGiftModel = XWGiftModel(senderName: "发送人", senderURL: "icon", giftName: "玫瑰花", giftURL: "giftUrl")
        giftContainerView.showGiftModel(giftModel)
        
    }
    @IBAction func gift2(_ sender: UIButton) {
        let giftModel2 : XWGiftModel = XWGiftModel(senderName: "发送人2", senderURL: "icon2", giftName: "玫瑰花", giftURL: "giftUrl2")
        giftContainerView.showGiftModel(giftModel2)
    }
    @IBAction func gift3(_ sender: UIButton) {
        let giftModel3 : XWGiftModel = XWGiftModel(senderName: "发送人3", senderURL: "icon3", giftName: "玫瑰花", giftURL: "giftUrl3")
        giftContainerView.showGiftModel(giftModel3)
    }


}

