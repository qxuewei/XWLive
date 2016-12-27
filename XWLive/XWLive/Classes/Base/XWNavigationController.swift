//
//  XWNavigationController.swift
//  XWLive
//
//  Created by 邱学伟 on 2016/12/15.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

import UIKit

class XWNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        runtimeAddPanGes()
    }
    private func runtimeAddPanGes() {
        guard let targets = interactivePopGestureRecognizer!.value(forKey:  "_targets") as? [NSObject] else { return }
        let targetObjc = targets[0]
        let target = targetObjc.value(forKey: "target")
        let action = Selector(("handleNavigationTransition:"))
        let panGes = UIPanGestureRecognizer(target: target, action: action)
        view.addGestureRecognizer(panGes)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}
