//
//  ServerManager.swift
//  XWServer
//
//  Created by 邱学伟 on 2017/1/7.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import Cocoa

class ServerManager: NSObject {
    fileprivate lazy var serverSocket : TCPServer = TCPServer(addr:"192.168.1.110", port:7878)
    static let shareInstance : ServerManager = ServerManager()
    fileprivate var isServerRunning : Bool = false
    fileprivate lazy var cilents : [ClientManager] = [ClientManager]()
}

extension ServerManager {
    func startServer()  {
        serverSocket.listen()
        isServerRunning = true
        DispatchQueue.global().async {
            while self.isServerRunning {
                if let client = self.serverSocket.accept() {
                    print("发现一个客户端连接服务器")
                    self.handlerClient(client)
                }
            }
        }
        
    }
    
    func stopServer()  {
        isServerRunning = false
    }
}

extension ServerManager {
    fileprivate func handlerClient(_ client : TCPClient){
        let manager : ClientManager = ClientManager(client)
        cilents.append(manager)
        manager.startReadMsg()
    }
}
