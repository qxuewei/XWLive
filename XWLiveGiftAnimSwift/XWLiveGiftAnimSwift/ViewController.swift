//
//  ViewController.swift
//  XWLiveGiftAnimSwift
//
//  Created by 邱学伟 on 2017/3/31.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var digitLabel: XWGiftDigitLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        digitLabel.showDigitAnimation { 
            print("动画结束")
        }
    }
    @IBAction func gift1(_ sender: UIButton) {
        
    }
    @IBAction func gift2(_ sender: UIButton) {
        
    }
    @IBAction func gift3(_ sender: UIButton) {
        
    }


}

