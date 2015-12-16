//
//  HMZStatusRetweetedView.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/15.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SnapKit
import FFLabel

class HMZStatusRetweetedView: UIView {

    /// 底部约束属性
    var bottomConstraints: Constraint?
    
    var retweetedStatus: HMZStatus? {
        didSet {
            retweetedLabel.text = "@" + (retweetedStatus?.user?.name ?? "") + ": " + (retweetedStatus?.text ?? "")
            // 使用约束属性  记录可能产生复用的约束  将可能复用的约束 解除掉
            bottomConstraints?.uninstall()
            
            //设置配图视图的图片数组
            //智能提示不好使
            if let urls = retweetedStatus?.imageURLs where urls.count != 0 {
                //有配图视图
                //1.设置数据源
                photoView.imageURLs = urls
                //2.更改视图的底部约束
                self.snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomConstraints =  make.bottom.equalTo(photoView.snp_bottom).offset(StatusCellMargin).constraint
                })
                //显示配图视图
                photoView.hidden = false
            } else {
                //没有配图视图  更改底部约束
                self.snp_updateConstraints(closure: { (make) -> Void in
                    //记录底部约束
                    //1.对底部添加约束  2.转换成约束对象 并且使用属性记录
                    self.bottomConstraints =  make.bottom.equalTo(retweetedLabel.snp_bottom).offset(StatusCellMargin).constraint
                })
                //隐藏配图视图
                photoView.hidden = true
            }
        }
    }
    //MARK: 重写构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: 设置UI 及布局
    private func setupUI() {
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        //添加子视图
        addSubview(retweetedLabel)
        retweetedLabel.labelDelegate = self
        addSubview(photoView)
        
        //添加转发微博正文的约束
        retweetedLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left).offset(StatusCellMargin)
            make.top.equalTo(self.snp_top).offset(StatusCellMargin)
        }
        
        photoView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(retweetedLabel.snp_left)
            make.top.equalTo(retweetedLabel.snp_bottom).offset(StatusCellMargin)
            //            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        //添加底部约束
        self.snp_makeConstraints { (make) -> Void in
            self.bottomConstraints = make.bottom.equalTo(photoView.snp_bottom).offset(StatusCellMargin).constraint
        }
    }
    
    //MARK: 懒加载所有的子控件
    private lazy var retweetedLabel: FFLabel = FFLabel(title: "转发微博", color: UIColor.darkGrayColor(), fontSize: 14, margin: StatusCellMargin)
    
    private lazy var photoView: HMZStatusPhotoView = HMZStatusPhotoView()
    
}


extension HMZStatusRetweetedView: FFLabelDelegate {
    //实现协议方法
    func labelDidSelectedLinkText(label: FFLabel, text: String) {
        print(text)
        if text.hasPrefix("http") {
            //进行页面跳转
            let temp = HMZTempWebViewController()
            temp.urlString = text
            self.getNavController()?.pushViewController(temp, animated: true)
            
        }
    }
}


