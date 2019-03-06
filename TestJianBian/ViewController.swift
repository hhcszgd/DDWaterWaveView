//
//  ViewController.swift
//  TestJianBian
//
//  Created by WY on 2019/3/6.
//  Copyright © 2019 WY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var waterView1 =  DDWaterWaveView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height/2), startColor: DDColorByHex(0x90cfed, 0.7), endColor: DDColorByHex(0xff785c, 0.7))
    lazy var waterView2 =  DDWaterWaveView(frame: CGRect(x: 0, y: self.view.bounds.height/2, width: self.view.bounds.width, height: self.view.bounds.height/2), startColor: DDColorByHex(0x90cfed, 0.3), endColor: DDColorByHex(0x21e2aa, 0.7))
//    lazy var waterView1 =  DDWaterWaveView(frame:  self.view.bounds, startColor: DDColorByHex(0x90cfed, 0.7), endColor: DDColorByHex(0xff785c, 0.7))
//    lazy var waterView2 =  DDWaterWaveView(frame: self.view.bounds, startColor: DDColorByHex(0x90cfed, 0.3), endColor: DDColorByHex(0x21e2aa, 0.7))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = DDColorByHex(0xfafbff);
        self.view.addSubview(waterView1)
        self.view.addSubview(waterView2)

    }
}

import QuartzCore
import CoreGraphics
func DDColorByHex(_ hexValue : Int , _ alpha: CGFloat = 1) -> UIColor {
    return UIColor.init(red: ((CGFloat)(((hexValue) & 0xFF0000) >> 16))/255.0, green: ((CGFloat)(((hexValue) & 0xFF00) >> 8))/255.0, blue: ((CGFloat)((hexValue) & 0xFF))/255.0, alpha: alpha)
}
class DDWaterWaveView : UIView{
    /** 振幅*/
    var  waveAmplitude : CGFloat = 0
    /** 周期*/
    var  waveCycle : CGFloat = 0
    /** 速度*/
    var  waveSpeed : CGFloat = 0
    var waveHeight : CGFloat = 0
    var waveWidth : Int = 0
    var wavePointY: CGFloat = 0
    /** 波浪x位移*/
    var  waveOffsetX: CGFloat = 0
    /** 波浪颜色*/
    var waveColor = UIColor.red
    
    var  startColor = UIColor.blue
    var  endColor = UIColor.orange
    lazy var displayLink : CADisplayLink = CADisplayLink(target: self , selector: #selector(getCurrentWave))
    var shapeLayer1 : CAShapeLayer = CAShapeLayer()
    var shapeLayer2 = CAShapeLayer()
    lazy var  gradientLayer1 : CAGradientLayer = {
            let gradientLayer1 = CAGradientLayer()
            gradientLayer1.frame = self.bounds;
            gradientLayer1.colors = [self.startColor.cgColor,self.endColor.cgColor]
            gradientLayer1.locations = [0, 1.0]
            gradientLayer1.startPoint = CGPoint(x:0,y: 0);
            gradientLayer1.endPoint = CGPoint(x:1.0,y: 0);
            return gradientLayer1;
    }()
    lazy var gradientLayer2 : CAGradientLayer = {
        let gradientLayer1 = CAGradientLayer()
        gradientLayer1.frame = self.bounds;
        gradientLayer1.colors = [self.startColor.cgColor,self.endColor.cgColor]
        gradientLayer1.locations = [0, 1.0]
        gradientLayer1.startPoint = CGPoint(x:0,y: 0);
        gradientLayer1.endPoint = CGPoint(x:1.0,y: 0);
        return gradientLayer1;
    }()
    convenience  init(frame: CGRect , startColor:UIColor , endColor : UIColor) {
        self.init(frame: frame)
        self.startColor = startColor;
        self.endColor = endColor;
        self.backgroundColor = DDColorByHex(0xedf0f4, 0.1);
        self.layer.masksToBounds = true;
        self.backgroundColor = UIColor.clear
        self.ConfigParams()
        
        self.startWave()
    }
    
    
    
    //pragma mark 配置参数
    func ConfigParams() {
    if (waveWidth == 0) {
        waveWidth = Int(self.frame.size.width)
    }
    if (waveHeight == 0) {
        waveHeight = 10;
    }
    //  背景色
    if (waveColor == UIColor.white) {
        waveColor = UIColor.white
    }
    
    if (waveSpeed == 0) {
        waveSpeed = 2.5
    }
    if ( waveOffsetX == 0 ) {
        waveOffsetX = 0;
    }
    if (wavePointY == 0) {
        wavePointY = 208;
    }
    if (  waveAmplitude == 0 ) {
        waveAmplitude = 10;
    }
    if (waveCycle == 0) {
        waveCycle =  CGFloat(1.29 * M_PI) / CGFloat(waveWidth)
    }
    }
    
    //#pragma mark 加载layer ，绑定runloop 帧刷新
    func startWave() {
        self.layer.addSublayer(self.shapeLayer1)
        self.layer.addSublayer(self.shapeLayer2)
        self.displayLink.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
    }
    
    //pragma mark - 帧动画
    @objc func getCurrentWave() {
        waveOffsetX += waveSpeed;
        self.changeFirstWaveLayerPath()
        self.changeSecondWaveLayerPath()
        
        self.layer.addSublayer(self.gradientLayer1)
        self.gradientLayer1.mask = shapeLayer1;
        
        self.layer.addSublayer(self.gradientLayer2)
        self.gradientLayer2.mask = shapeLayer2
    }
    
    //pragma mark - 路径
    func changeFirstWaveLayerPath() {
        var path = CGMutablePath()
        var y = wavePointY;
        path.move(to: CGPoint(x: 0, y: y))
    
        for x in 0...waveWidth {
            let danymicx = (CGFloat(x) * CGFloat(M_PI) / 180)
            
            let p2 = sin((250 / CGFloat(waveWidth)) * danymicx - waveOffsetX * CGFloat(M_PI) / 270)
            y = waveAmplitude * 1.6 * p2 + wavePointY;
            path.addLine(to: CGPoint(x: CGFloat(x), y: y))
        }
//
        path.addLine(to: CGPoint(x: CGFloat(waveWidth), y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        shapeLayer1.path = path;
    }
    
    func changeSecondWaveLayerPath() {
        var path = CGMutablePath()
        var y = wavePointY
        path.move(to: CGPoint(x: 0, y: y))
        for x in 0...waveWidth {
            let danymicx = (CGFloat(x) * CGFloat(M_PI) / 180)
            let p2 = sin((250 / CGFloat(waveWidth)) * danymicx - waveOffsetX * CGFloat(M_PI) / 180)
            y = waveAmplitude * 1.6 * p2 + wavePointY;
            path.addLine(to: CGPoint(x: CGFloat(x), y: y))
        }

        path.addLine(to: CGPoint(x: CGFloat(waveWidth), y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        shapeLayer2.path = path;
    }
    deinit {
        displayLink.invalidate()
    }
}
