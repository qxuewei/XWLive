//
//  ViewController.swift
//  XWServer
//
//  Created by 邱学伟 on 2017/1/6.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var serverStateLB: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func startServer(_ sender: NSButton) {
        ServerManager.shareInstance.startServer()
        serverStateLB.stringValue = "服务器开启中..."
    }
    @IBAction func stopServer(_ sender: NSButton) {
        ServerManager.shareInstance.stopServer()
        serverStateLB.stringValue = "服务器关闭"
    }
    

}

