//
//  XWSocket.swift
//  XWClient
//
//  Created by 邱学伟 on 2017/1/13.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

class XWSocket {
    fileprivate var tcpClient : TCPClient
    init(addr : String, port : Int) {
        self.tcpClient = TCPClient(addr: addr, port: port)
    }
    init(client : TCPClient) {
        self.tcpClient = client
    }
}

extension XWSocket {
    // 建立连接
    func connectServer() -> Bool {
        return tcpClient.connect(timeout: 5).0
    }
    func sendMsg(msg : String) {
        tcpClient.send(str: msg)
    }
}
