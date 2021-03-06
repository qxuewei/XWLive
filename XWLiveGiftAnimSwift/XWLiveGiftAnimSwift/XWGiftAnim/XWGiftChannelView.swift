//
//  XWGiftChannelView.swift
//  XWLiveGiftAnimSwift
//
//  Created by 邱学伟 on 2017/3/31.
//  Copyright © 2017年 邱学伟. All rights reserved.
//  渠道

import UIKit
enum XWGiftChannelState {
    case idle   //闲置
    case animating  //正在执行动画
    case willEnd    //准备结束(等待三秒)
    case endAnimating   //正在消失
}
class XWGiftChannelView: UIView {
    // MARK: 控件属性
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var giftDescLabel: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var digitLabel: XWGiftDigitLabel!
    
    // MARK: - 属性
    var channelState : XWGiftChannelState = .idle
    var currentNum : Int = 0
    var cacheNumber : Int = 0 //礼物缓存
    var complectionCallback : ((XWGiftChannelView) -> Void)? //动画结束回调
    
    
    var giftModel : XWGiftModel? {
        didSet {
            guard let giftModel = giftModel else {
                return
            }
            // 给控件设置数据
            iconImageView.image = UIImage(named: giftModel.senderURL)
            senderLabel.text = giftModel.senderName
            giftDescLabel.text = "送出礼物：【\(giftModel.giftName)】"
            giftImageView.image = UIImage(named: giftModel.giftURL)
            
            // 3.将ChanelView弹出
            channelState = .animating
            performAnimation()
        }
    }
}

// MARK: - public
extension XWGiftChannelView {
    func addCacheNumber()  {
        if self.channelState == .willEnd {
            self.performDigitLabelAnim()
            NSObject.cancelPreviousPerformRequests(withTarget: self)
        }else{
            cacheNumber += 1
        }
    }
    
    class func loadFormNib() -> XWGiftChannelView {
        return Bundle.main.loadNibNamed("XWGiftChannelView", owner: self, options:nil)?.first as! XWGiftChannelView
    }
}


//MARK: - UI界面
extension XWGiftChannelView {
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layer.cornerRadius = frame.height * 0.5
        iconImageView.layer.cornerRadius = frame.height * 0.5
        bgView.layer.masksToBounds = true
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.green.cgColor
    }
}

// MARK: - 动画
extension XWGiftChannelView {
    // 弹出
   fileprivate func performAnimation() {
        digitLabel.alpha = 1.0
        digitLabel.text = " x1"
        UIView.animate(withDuration: 0.25, animations: { 
            self.frame.origin.x = 0
            self.alpha = 1.0
        }) { (finished) in
            self.performDigitLabelAnim()
        }
    }
    
    // 文字跳动
   fileprivate func performDigitLabelAnim() {
        currentNum += 1
        digitLabel.text = "x \(currentNum)"
        digitLabel.showDigitAnimation {
            
            if self.cacheNumber > 0 {
                self.cacheNumber -= 1
                self.performDigitLabelAnim()
            } else {
                self.channelState = .willEnd
                self.perform(#selector(self.performDidAnim), with: nil, afterDelay: 3)
            }
            
        }
    }
    
    // 消失
   @objc fileprivate func performDidAnim() {
        channelState = .endAnimating
        UIView.animate(withDuration: 0.25, animations: { 
            self.frame.origin.x = UIScreen.main.bounds.width
            self.alpha = 0.0
        }) { (finished) in
            self.giftModel = nil
            self.frame.origin.x = -self.frame.width
            self.channelState = .idle
            if (self.complectionCallback != nil) {
                self.complectionCallback!(self)
            }
        }
    }
}
