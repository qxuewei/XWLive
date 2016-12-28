//
//  NetworkTool.swift
//  XWLive
//
//  Created by 邱学伟 on 2016/12/27.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import Foundation
import Alamofire
enum RequestType {
    case get
    case post
}

class NetworkTool {
    class func requestData(_ requestType : RequestType, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping (_ result : Any) -> ()) {
        //1.获取类型
        let method = (requestType == .get ? HTTPMethod.get : HTTPMethod.post)
        //2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).validate(contentType: ["text/plain"]).responseJSON { (response) in
            //3.获取结果
            guard let result = response.result.value else {
                print("请求失败\(response.result.error!)")
                return
            }
            //4.结果回调
            finishedCallback(result)
        }
    }
}
