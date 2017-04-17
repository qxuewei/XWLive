//
//  XWGiftContainerView.swift
//  XWLiveGiftAnimSwift
//
//  Created by 邱学伟 on 2017/3/31.
//  Copyright © 2017年 邱学伟. All rights reserved.
//  礼物容器

import UIKit

private let kChannelCount = 2
private let kChannelViewH : CGFloat = 40
private let kChannelMargin : CGFloat = 10

class XWGiftContainerView: UIView {

    // MARK: 定义属性
    fileprivate lazy var channelViews : [XWGiftChannelView] = [XWGiftChannelView]()
    fileprivate lazy var cacheGiftModels : [XWGiftModel] = [XWGiftModel]()
    
    // MARK: 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension XWGiftContainerView {
    func setupUI() {
        // 1.根据当前的渠道数，创建GiftChannelView
        let w : CGFloat = frame.width
        let h : CGFloat = kChannelViewH
        let x : CGFloat = 0
        for i in 0..<kChannelCount {
            let y : CGFloat = (h + kChannelMargin) * CGFloat(i)
            
            let channelView = XWGiftChannelView.loadFormNib()
            channelView.frame = CGRect(x: x, y: y, width: w, height: h)
            channelView.alpha = 0.0
            addSubview(channelView)
            channelViews.append(channelView)
            
            channelView.complectionCallback = { mChannelView in
                //1.取出缓存模型
                guard self.cacheGiftModels.count > 0  else {
                    return
                }
                //2.存在让闲置的channelView执行动画
                let firstGiftModel = self.cacheGiftModels.first
                self.cacheGiftModels.removeFirst()
                mChannelView.giftModel = firstGiftModel
                
                // 4.将数组中剩余有和firstGiftModel相同的模型放入到ChanelView缓存中
                for i in (0..<self.cacheGiftModels.count).reversed() {
                    let giftModel = self.cacheGiftModels[i]
                    if giftModel.isEqual(firstGiftModel) {
                        mChannelView.addCacheNumber()
                        self.cacheGiftModels.remove(at: i)
                    }
                }
            }
        }
    }
}

extension XWGiftContainerView {
    func showGiftModel(_ giftModel : XWGiftModel) {
        // 判断是否存在正在显示的channelView
        if let channelView = checkUsingChannelView(giftModel) {
            channelView.addCacheNumber()
            return
        }
        // 判断是否存在闲置的channelView
        if let channelView = chectkIdleChannelView() {
            channelView.giftModel = giftModel
            return
        }
        // 将数据放入缓存
        cacheGiftModels.append(giftModel)
    }
    private func checkUsingChannelView(_ giftModel : XWGiftModel) -> XWGiftChannelView? {
        for channelView in channelViews {
            if giftModel.isEqual(channelView.giftModel) && channelView.channelState != .endAnimating{
                return channelView
            }
        }
        return nil
    }
    private func chectkIdleChannelView() -> XWGiftChannelView? {
        for channelView in channelViews {
            if channelView.channelState == .idle {
                return channelView
            }
        }
        return nil
    }
}
