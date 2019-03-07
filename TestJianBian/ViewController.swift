//
//  ViewController.swift
//  TestJianBian
//
//  Created by WY on 2019/3/6.
//  Copyright © 2019 WY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var waterView1 =  DDWaterWaveView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height/3), startColor: DDColorByHex(0x90cfed, 0.7), endColor: DDColorByHex(0xff785c, 0.7))
//    lazy var waterView2 =  DDWaterWaveView(frame: CGRect(x: 0, y: self.view.bounds.height/3, width: self.view.bounds.width, height: self.view.bounds.height/3), startColor: DDColorByHex(0x90cfed, 0.3), endColor: DDColorByHex(0x21e2aa, 0.7))
//    lazy var waterView1 =  DDWaterWaveView(frame:  self.view.bounds, startColor: DDColorByHex(0x90cfed, 0.7), endColor: DDColorByHex(0xff785c, 0.7))
//    lazy var waterView2 =  DDWaterWaveView(frame: self.view.bounds, startColor: DDColorByHex(0x90cfed, 0.3), endColor: DDColorByHex(0x21e2aa, 0.7))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = DDColorByHex(0xfafbff);
        self.view.addSubview(waterView1)
//        self.view.addSubview(waterView2)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        waterView1.addTimer()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        waterView1.invalidTimer()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(DDTestViewController(), animated: true )
    }
}

