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
    fileprivate lazy var emoticonView : EmoticonView = EmoticonView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 240))
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendMsgBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    @IBAction func textFieldDidEdit(_ sender: UITextField) {
        sendMsgBtn.isEnabled = (inputTextField.text?.characters.count != 0)
        
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

//MARK: - UI
extension ChatToolsView {
    fileprivate func setUpUI() {
        emoticonBtn.setImage(UIImage(named: "chat_btn_emoji"), for: .normal)
        emoticonBtn.setImage(UIImage(named: "chat_btn_keyboard"), for: .selected)
        emoticonBtn.addTarget(self, action: #selector(emoticonBtnClick(_:)), for: .touchUpInside)
        inputTextField.rightView = emoticonBtn
        inputTextField.rightViewMode = .always
        weak var weakSelf = self
        emoticonView.emoticonClickBlock = { emoticon -> Void in
            weakSelf?.insertEmoticon(emoticon)
        }
    }
}

//MARK: - Selector
extension ChatToolsView {
    @objc func emoticonBtnClick(_ btn : UIButton) {
        btn.isSelected = !btn.isSelected
        let currentTextRange : UITextRange = inputTextField.selectedTextRange!
        inputTextField.resignFirstResponder()
        inputTextField.inputView = (inputTextField.inputView == nil ? emoticonView : nil)
        inputTextField.becomeFirstResponder()
        inputTextField.selectedTextRange = currentTextRange
    }
    /// 插入表情(文字)
    fileprivate func insertEmoticon(_ emoticon : Emoticon) {
        if emoticon.emoticonName == "delete-n" {
            self.inputTextField.deleteBackward()
            return
        }
        guard let inputTextRange = inputTextField.selectedTextRange else {
            return
        }
        inputTextField.replace(inputTextRange, withText: emoticon.emoticonName)
    }
    /// 插入表情(富文本) -> UITextField 无法富文本
//    fileprivate func insertEmoticon(_ emoticon : Emoticon) {
//        if emoticon.emoticonName == "delete-n" {
//            self.inputTextField.deleteBackward()
//            return
//        }
//        guard let inputTextRange : UITextRange = inputTextField.selectedTextRange else {
//            return
//        }
//        guard let emoticonImage = UIImage(named: emoticon.emoticonName) else {
//            return
//        }
//        let attachment : NSTextAttachment = NSTextAttachment()
//        attachment.image = emoticonImage
//        inputTextField.attributedText = NSAttributedString(attachment: attachment)
//    }
    
    ///  UITextRange -> NSRange
    func selectedRange(_ textField : UITextField) -> NSRange {
        let beginning : UITextPosition = textField.beginningOfDocument
        let selectedTextRange : UITextRange = textField.selectedTextRange!
        let selectedStart : UITextPosition = selectedTextRange.start
        let selectedEnd : UITextPosition = selectedTextRange.end
        let location : NSInteger = textField.offset(from: beginning, to: selectedStart)
        let length : NSInteger = textField.offset(from: selectedStart, to: selectedEnd)
        return NSRange(location: location, length: length)
    }
}
