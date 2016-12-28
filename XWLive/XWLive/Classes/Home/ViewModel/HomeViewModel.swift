//
//  HomeViewModel.swift
//  XWLive
//
//  Created by 邱学伟 on 2016/12/27.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import Foundation

class HomeViewModel {
    lazy var anchorModels = [AnchorModel]()
}

extension HomeViewModel {
    func loadHomeData(type : HomeType, index : Int, finishedCallback : @escaping () -> ()) {
        NetworkTool.requestData(.get, URLString: "http://qf.56.com/home/v4/moreAnchor.ios", parameters: ["type" : type.type, "index" : index, "size" : 48],finishedCallback:  { (result) -> Void in
            guard let resultDict = result as? [String : Any] else {
                return
            }
            guard let messageDict = resultDict["message"] as? [String : Any] else{
                return
            }
            guard let dataArray = messageDict["anchors"] as? [[String : Any]] else{
                return
            }
            
            for (index, dict) in dataArray.enumerated() {
                let anchor = AnchorModel(dict: dict)
                anchor.isEvenIndex = index % 2 == 0
                self.anchorModels.append(anchor)
            }
            finishedCallback()
        })
    }
}
