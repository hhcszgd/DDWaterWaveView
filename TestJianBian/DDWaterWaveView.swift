//
//  DDWaterWaveView.swift
//  TestJianBian
//
//  Created by WY on 2019/3/7.
//  Copyright © 2019 WY. All rights reserved.
//

import UIKit
import QuartzCore
import CoreGraphics
func DDColorByHex(_ hexValue : Int , _ alpha: CGFloat = 1) -> UIColor {
    return UIColor.init(red: ((CGFloat)(((hexValue) & 0xFF0000) >> 16))/255.0, green: ((CGFloat)(((hexValue) & 0xFF00) >> 8))/255.0, blue: ((CGFloat)((hexValue) & 0xFF))/255.0, alpha: alpha)
}
class DDWaterWaveView : UIView{
    var count  = 0
    
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
    var timer : Timer?
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
        
        self.layer.addSublayer(self.shapeLayer1)
        self.layer.addSublayer(self.shapeLayer2)
        self.startWave()
    }
    func addTimer()  {
        self.invalidTimer()
        timer = Timer.init(timeInterval: 0.01, target: self, selector: #selector(getCurrentWave), userInfo: nil , repeats: true )
        RunLoop.main.add(self.timer!, forMode: RunLoop.Mode.common)
    }
    func invalidTimer() {
        if let tempTimer  = timer {
            tempTimer.invalidate()
            timer = nil
        }
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
        addTimer()
    }
    //    var cccc = 0
    
    //pragma mark - 帧动画
    @objc func getCurrentWave() {
        //            let result = sin(CGFloat(cccc ) / 10)
        //            print(result)
        //            cccc += 1
        //
        //
        //
        //        return
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
            count += 1
            //            print("xxxxxxxxxxxxxxxxxxxxxxxxxxx\(count )")
        }
        //
        path.addLine(to: CGPoint(x: CGFloat(waveWidth), y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        shapeLayer1.path = path;
    }
    @objc override func theviewDidAppear() {
        print("各个子类调用")
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
        invalidTimer()
    }
}
extension UIView{
    @objc  func theviewDidAppear() {
        print("view did appear o")
    }
}
