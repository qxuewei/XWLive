//
//  Emitterable.swift
//  XWLive
//
//  Created by 邱学伟 on 2017/3/18.
//  Copyright © 2017年 邱学伟. All rights reserved.
//  粒子效果协议

import Foundation
import UIKit
protocol Emitterable {
    
}

extension Emitterable where Self : UIViewController {
    
    func starEmittering(_ point : CGPoint) {
        
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = point
        emitter.preservesDepth = true       //三维效果
        var cells = [CAEmitterCell]()
        for i in 0..<10 {
            let cell = CAEmitterCell()
            cell.velocity = 150             //速度
            cell.velocityRange = 100
            cell.scale = 0.7                //粒子大小
            cell.scaleRange = 0.3
            cell.emissionLongitude = CGFloat(-M_PI_2)   //粒子方向
            cell.emissionRange = CGFloat(M_PI_2 / 6)
            cell.lifetime = 3   //存活时间
            cell.lifetimeRange = 1.5
            cell.spin = CGFloat(M_PI_2)//粒子旋转
            cell.scaleRange = CGFloat(M_PI_4)
            cell.birthRate = 2;
            cell.contents = UIImage(named: "good\(i)_30x30")?.cgImage
            cells.append(cell)
        }
        emitter.emitterCells = cells
        view.layer.addSublayer(emitter)
    }
    
    func stopEmittering() {
//        for layer in view.layer.sublayers! {
//            if layer.isKind(of: CAEmitterCell.self) {
//                layer.removeFromSuperlayer()
//            }
//        }
        view.layer.sublayers?.filter({ $0.isKind(of: CAEmitterCell.self) }).first?.removeFromSuperlayer()
    }
}
