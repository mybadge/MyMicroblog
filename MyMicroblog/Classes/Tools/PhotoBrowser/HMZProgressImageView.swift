//
//  HMZProgressImageView.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/23.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
/// 带进度条的图像视图
class HMZProgressImageView: UIImageView {
    
    /// 外部传递的进度值
    var progress: CGFloat = 0 {
        didSet {
            progressView.progress = progress
        }
    }
  
    init() {
        super.init(frame: CGRectZero)
        addSubview(progressView)
        progressView.backgroundColor = UIColor.clearColor()
        
        progressView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.snp_edges)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var progressView: ProgressView = ProgressView()
}


/// 进度视图 ？？？ 为什么是私有的呢
private class ProgressView: UIView {
    
    var progress: CGFloat = 0 {
        didSet {
            //重绘视图
            setNeedsDisplay()
        }
    }
    
    private override func drawRect(rect: CGRect) {
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        let r = min(rect.width, rect.height) * 0.5
        let start = CGFloat(-M_PI_2)
        let end = start + progress * 2 * CGFloat(M_PI)
        
        /// 画园
        let path = UIBezierPath(arcCenter: center, radius: r, startAngle: start, endAngle: end, clockwise: true)
        path.addLineToPoint(center)
        path.closePath()
        UIColor(white: 0.6, alpha: 0.8).setFill()
        path.fill()
    }
}
