//
//  RoomViewController.swift
//  XWLive
//
//  Created by 邱学伟 on 2016/12/23.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit
private let kChatToolViewHeight : CGFloat = 44.0
private let kGiftlistViewHeight : CGFloat = kScreenH * 0.48
private let kChatContentViewHeight : CGFloat = 200

class RoomViewController: UIViewController {
    @IBOutlet weak var bgImageView: UIImageView!
    fileprivate var chatToolView : ChatToolsView = ChatToolsView.loadViewFromNib()
    fileprivate var giftListView : GiftListView = GiftListView.loadViewFromNib()
    fileprivate var chatContentView : ChatContentView = ChatContentView.loadViewFromNib()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addKeyboardNoti()
    }
    private func addKeyboardNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

//MARK: - UI
extension RoomViewController {
    fileprivate func setUpUI() {
        setupBlurView()
        setupChatToolView()
        setupGiftView()
        setupChatContentView()
    }
    /// 毛玻璃效果
    private func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageView.bounds
        bgImageView.addSubview(blurView)
    }
    /// 聊天展示视图
    func setupChatContentView() {
        
        chatContentView.frame = CGRect(x: 0, y: view.bounds.height - 44 - kChatContentViewHeight, width: view.bounds.width, height: kChatContentViewHeight)
        chatContentView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(chatContentView)
    }
    /// 聊天窗口
    private func setupChatToolView() {
        chatToolView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: kChatToolViewHeight)
        chatToolView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        view.addSubview(chatToolView)
        chatToolView.delegate = self
    }
    /// 礼物视图
    private func setupGiftView() {
        giftListView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: kGiftlistViewHeight)
        giftListView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        view.addSubview(giftListView)
        giftListView.delegate = self
    }
}


//MARK: - Selector
extension RoomViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        chatToolView.inputTextField.resignFirstResponder()
        if giftListView.frame.origin.y != kScreenH {
            UIView.animate(withDuration: 0.25, animations: {
                self.giftListView.frame.origin.y = kScreenH
            })
        }
    }
    @objc fileprivate func keyboardWillChangeFrame(_ noti : NSNotification) {
        let duration : Double = noti.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let endFrame : CGRect = (noti.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let chatToolViewNewY : CGFloat = (endFrame.origin.y - kChatToolViewHeight)
        UIView.animate(withDuration: duration) {
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
           let endY = (chatToolViewNewY == (kScreenH - kChatToolViewHeight) ? kScreenH : chatToolViewNewY)
            self.chatToolView.frame.origin.y = endY
        }
    }
    @IBAction func exitBtnClick() {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func bottomMenuClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            chatToolView.inputTextField.becomeFirstResponder()
            
        case 1:
            print("点击了分享")
        case 2:
            UIView.animate(withDuration: 0.25, animations: {
                self.giftListView.frame.origin.y -= kGiftlistViewHeight
            })
        case 3:
            print("点击了更多")
        case 4:
            print("点击了粒子")
        default:
            fatalError("未处理按钮")
        }
    }

}

extension RoomViewController : ChatToolsViewDelegate{
    func chatToosView(chatToolsView: ChatToolsView, message: String) {
        print("发送内容: \(message)")
    }
}

extension RoomViewController : GiftListViewDelegate {
    func giftListView(_ giftListView: GiftListView, giftModel: GiftModel) {
        print("送礼物:\(giftModel.subject)")
        if giftListView.frame.origin.y != kScreenH {
            UIView.animate(withDuration: 0.25, animations: {
                self.giftListView.frame.origin.y = kScreenH
            })
        }
    }
}
