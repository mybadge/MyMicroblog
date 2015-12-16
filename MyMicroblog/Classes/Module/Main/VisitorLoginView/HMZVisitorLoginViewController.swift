//
//  HMZVisitorLoginView.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/12.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

//MARK: - 定义协议
@objc protocol HMZVisitorLoginViewDelegate: NSObjectProtocol {
    optional func userWillLogin()
    func userWillRegister()
}


class HMZVisitorLoginView: UIView {
    //代理要用weak
    weak var delegate: HMZVisitorLoginViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - 属性方法
    func setupInfo(tipText: String, imageName: String?) {
        tipLabel.text = tipText
        if let name = imageName { //不是首页
            circleView.image = UIImage(named: name)
            largeIcon.hidden = true
            
            //将circleView 移动到顶层
            bringSubviewToFront(circleView)
        }else {
            startAnimation()
        }
        
    }
    
    private func startAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.repeatCount = MAXFLOAT
        anim.duration = 20
        anim.toValue = 2 * M_PI
        
        //当动画完毕或者页面失去活跃状态时 不移除动画图层
        anim.removedOnCompletion = false
        //添加动画
        circleView.layer.addAnimation(anim, forKey: nil)
    }
    
    
    
    
    
    
    //MARK: - 监听方法
    @objc private func registerBtnDidClick() {
        delegate?.userWillRegister()
    }
    
    @objc private func loginBtnDidClick() {
        delegate?.userWillLogin?()
    }
   
   
    //MARK: - 懒加载
    private lazy var backView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    private lazy var largeIcon: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    private lazy var circleView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    private lazy var tipLabel: UILabel  = UILabel(title: "关注一些人，回这里看看有什么惊喜,关注一些人，回这里看看有什么惊喜", fontSize: 14)
    
    private lazy var registerBtn: UIButton = {
        let btn = UIButton()
        var image = UIImage(named: "common_button_white_disable2")!
        image = image.stretchableImageWithLeftCapWidth(Int(image.size.width * 0.5), topCapHeight: Int(image.size.height * 0.5))
        btn.setBackgroundImage(image, forState: .Normal)
        btn.setTitle("注册", forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        btn.setTitleColor(HMZThemeColor, forState: .Normal)
        btn.addTarget(self, action: "registerBtnDidClick", forControlEvents: .TouchUpInside)
        return btn
    }()
    
    private lazy var loginBtn: UIButton = UIButton(title: "登录", backgroundImage: "common_button_white_disable", color: UIColor.darkGrayColor(), fontSize: 15, isNeedHighighted: true, imageName: nil)
    }

//MARK: - 初始化视图
extension HMZVisitorLoginView {
    ///设置所有的子视图
    func setupUI() {
        addSubview(circleView)
        addSubview(backView)
        addSubview(largeIcon)
        addSubview(tipLabel)
        addSubview(registerBtn)
        addSubview(loginBtn)
        
        for sub in subviews {
            //在使用手码添加约束 需要屏蔽 frame布局
            sub.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraint(NSLayoutConstraint(item: largeIcon, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: largeIcon, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: -60))
        //设置圆环的约束
        addConstraint(NSLayoutConstraint(item: circleView, attribute: .CenterX, relatedBy: .Equal, toItem: largeIcon, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: circleView, attribute: .CenterY, relatedBy: .Equal, toItem: largeIcon, attribute: .CenterY, multiplier: 1, constant: 0))
        
        //设置 tipLabel 的约束
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .CenterX, relatedBy: .Equal, toItem: circleView, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .Top, relatedBy: .Equal, toItem: circleView, attribute: .Bottom, multiplier: 1, constant: 16))
        //If your equation does not have a second view and attribute, use nil and NSLayoutAttributeNotAnAttribute.
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 230))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 40))
        
        //按钮的约束
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Left, relatedBy: .Equal, toItem: tipLabel, attribute: .Left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Top, relatedBy: .Equal, toItem: tipLabel, attribute: .Bottom, multiplier: 1, constant: 20))
        //If your equation does not have a second view and attribute, use nil and NSLayoutAttributeNotAnAttribute.
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 35))
        
        
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Right, relatedBy: .Equal, toItem: tipLabel, attribute: .Right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Top, relatedBy: .Equal, toItem: tipLabel, attribute: .Bottom, multiplier: 1, constant: 20))
        //If your equation does not have a second view and attribute, use nil and NSLayoutAttributeNotAnAttribute.
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 35))
        
        //设置背景视图的约束 可视化的布局语言
        //OC 中可选项 一般使用 按位 或枚举选项  swift中直接指定数组
        //metrics:约束数值字典 [String: 数值],
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[backView]-0-|", options: [], metrics: nil, views: ["backView":backView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[backView]-(-35)-[loginBtn]", options: [], metrics: nil, views: ["backView":backView, "loginBtn":loginBtn]))
        
        //设置View 的灰色
        backgroundColor = UIColor(white: 0.93, alpha: 1)
    }
}
