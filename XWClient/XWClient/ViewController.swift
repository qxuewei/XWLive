//
//  ViewController.swift
//  XWClient
//
//  Created by 邱学伟 on 2017/1/13.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate lazy var tcpServer : TCPServer = TCPServer(addr: "192.168.1.110", port: 7878)
    fileprivate lazy var tcpClient : TCPClient = TCPClient(addr: "192.168.1.110", port: 7878)
    fileprivate lazy var myScoket : XWSocket = XWSocket(addr: "192.168.1.110", port: 7878)

    override func viewDidLoad() {
        super.viewDidLoad()
        if myScoket.connectServer() {
            print("客户端连接服务器...")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        myScoket.sendMsg(msg: "你好啊, 李银河") //"Hello World!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

