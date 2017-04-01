//
//  XWGiftDigitLabel.swift
//  XWLiveGiftAnimSwift
//
//  Created by 邱学伟 on 2017/3/31.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

class XWGiftDigitLabel: UILabel {

    override func drawText(in rect: CGRect) {
        let content = UIGraphicsGetCurrentContext()
        content?.setLineWidth(5)
        content?.setLineJoin(.round)
        content?.setTextDrawingMode(.stroke)
        textColor = UIColor.orange
        super.drawText(in: rect)
        
        content?.setTextDrawingMode(.fill)
        textColor = UIColor.white
        super.drawText(in: rect)
    }
    
    func showDigitAnimation(_ complection: @escaping () -> ())  {
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(scaleX: 3.0, y: 3.0);
        }) { (isFinished) in
            UIView.animate(withDuration: 0.25, animations: { 
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7);
            }, completion: { (isFinished) in
                UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                    self.transform = CGAffineTransform.identity
                }, completion: { (isFinished) in
                    complection()
                });
            })
        };
    }
}


