//
//  DDTestViewController.swift
//  TestJianBian
//
//  Created by WY on 2019/3/7.
//  Copyright © 2019 WY. All rights reserved.
//

import UIKit

class DDTestViewController: UIViewController {
    let label = UILabel()
    lazy var waterView1 =  DDWaterWaveView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height/3), startColor: DDColorByHex(0x90cfed, 0.7), endColor: DDColorByHex(0xff785c, 0.7))
//    lazy var waterView2 =  DDWaterWaveView(frame: CGRect(x: 0, y: self.view.bounds.height/3, width: self.view.bounds.width, height: self.view.bounds.height/3), startColor: DDColorByHex(0x90cfed, 0.3), endColor: DDColorByHex(0x21e2aa, 0.7))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(waterView1)
        self.view.backgroundColor = .white
//        self.view.addSubview(waterView2)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
