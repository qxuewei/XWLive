//
//  ClientManager.swift
//  XWServer
//
//  Created by 邱学伟 on 2017/1/13.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import Cocoa

class ClientManager: NSObject {
    var tcpCilent : TCPClient
    
    init(_ tcpC : TCPClient) {
        self.tcpCilent = tcpC
    }
}

extension ClientManager {
    func startReadMsg() {
        while true {
            if let msg : [UInt8] = tcpCilent.read(20) {
                // char 字符串转化 data
                let msgData : Data = Data(bytes: msg, count: 20)
                let msgStr =  String(data: msgData, encoding: .utf8)
                print("服务器读取消息:\(msgStr)")
                
            }else{
                print("服务器断开连接")
            }
        }
    }
}
