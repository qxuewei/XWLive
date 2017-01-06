//
//  GiftViewModel.swift
//  XWLive
//
//  Created by 邱学伟 on 2017/1/6.
//  Copyright © 2017年 邱学伟. All rights reserved.
//
import UIKit

class GiftViewModel {
    lazy var giftlistData : [GiftPackage] = [GiftPackage]()
}

extension GiftViewModel {
    func loadGiftData(finishedCallback : @escaping () -> ()) {
        // http://qf.56.com/pay/v4/giftList.ios?type=0&page=1&rows=150
        
        if giftlistData.count != 0 { finishedCallback() }
        
        NetworkTool.requestData(.get, URLString: "http://qf.56.com/pay/v4/giftList.ios", parameters: ["type" : 0, "page" : 1, "rows" : 150], finishedCallback: { result in
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let dataDict = resultDict["message"] as? [String : Any] else { return }
            
            for i in 0..<dataDict.count {
                guard let dict = dataDict["type\(i+1)"] as? [String : Any] else { continue }
                self.giftlistData.append(GiftPackage(dict: dict))
            }
            
            print("giftlistData.count: +++ \(self.giftlistData.count)")
            self.giftlistData = self.giftlistData.filter({ return $0.t != 0 }).sorted(by: { return $0.t > $1.t })
             print("giftlistData.count: +++ \(self.giftlistData.count)")
            finishedCallback()
        })
    }
}

