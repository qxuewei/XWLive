//
//  ChatContentView.swift
//  XWLive
//
//  Created by 邱学伟 on 2017/3/20.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

private let kChatContentCellID = "kChatContentCellID"

class ChatContentView: UIView , Nibloadable {

    @IBOutlet weak var tableView: UITableView!
    fileprivate lazy var messages = [NSAttributedString]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.register(UINib(nibName: "ChatContentCell", bundle: nil), forCellReuseIdentifier: kChatContentCellID)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 40//高度自适应
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func insertMsg(_ message : NSAttributedString) {
        messages.append(message)
        tableView.reloadData()
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

extension ChatContentView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatContentCellID, for: indexPath) as! ChatContentCell
        cell.contentLabel.attributedText = messages[indexPath.row]
        return cell
    }
}
