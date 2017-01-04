//
//  ChatToolsView.swift
//  XWLive
//
//  Created by 邱学伟 on 2017/1/4.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit
protocol ChatToolsViewDelegate : class {
    func chatToosView(chatToolsView : ChatToolsView, message : String)
}
class ChatToolsView: UIView, Nibloadable {
    weak var delegate : ChatToolsViewDelegate?
    fileprivate lazy var emoticonBtn : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendMsgBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    @IBAction func textFieldDidEdit(_ sender: UITextField) {
        sender.isEnabled = (inputTextField.text?.characters.count != 0)
        print("textFieldDidEdit")
    }
    
    @IBAction func sendBtnClick(_ sender: UIButton) {
        // 1.获取内容
        let message = inputTextField.text!
        
        // 2.清空内容
        inputTextField.text = ""
        sender.isEnabled = false
        
        // 3.将内容回调出去
        delegate?.chatToosView(chatToolsView: self, message: message)
    }

}

extension ChatToolsView {
    fileprivate func setUpUI() {
        emoticonBtn.setImage(UIImage(named: "chat_btn_emoji"), for: .normal)
        emoticonBtn.setImage(UIImage(named: "chat_btn_keyboard"), for: .selected)
        emoticonBtn.addTarget(self, action: #selector(emoticonBtnClick(_:)), for: .touchUpInside)
        inputTextField.rightView = emoticonBtn
        inputTextField.rightViewMode = .always
    }
}

extension ChatToolsView {
    @objc func emoticonBtnClick(_ btn : UIButton) {
        btn.isSelected = !btn.isSelected
        inputTextField.resignFirstResponder()
        inputTextField.inputView = (inputTextField.inputView == nil ? UISwitch() : nil)
        inputTextField.becomeFirstResponder()
    }
}
