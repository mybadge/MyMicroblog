//
//  HMZWelcomeViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/14.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class HMZWelcomeViewController: UIViewController {
    
    override func loadView() {
        view = backImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        iconView.sd_setImageWithURL(HMZUserAccountViewModel.shareViewModel.headImageURL, placeholderImage: nil)
    }
    
    deinit {
        print("欢迎页面释放了")
    }
    
    //动画建议在viewDidAppear中执行
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    func setupUI() {
        view.addSubview(iconView)
        view.addSubview(welcomeLabel)
        
        //自动布局
        iconView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp_centerX)
            make.bottom.equalTo(view.snp_bottom).offset(-200)
            make.size.equalTo(CGSizeMake(100, 100))
        }
        welcomeLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_centerX)
            make.top.equalTo(iconView.snp_bottom).offset(26)
        }
        
        iconView.layer.cornerRadius = 50
        iconView.layer.masksToBounds = true
    }
    
    func startAnimation() {
        let offset = -screenH + 200
        iconView.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(offset)
        }
        /**
        iOS 7.0 推出的动画效果   弹簧系数 * 10  ~= 加速度
        - duartion                          持续事件
        - parameter delay:                  延迟时间
        - parameter usingSpringWithDamping: 弹簧效果 0.1 ~ 1之间  越小越弹
        - parameter initialSpringVelocity:  加速度
        - parameter options:                动画可选项
        - parameter animations:             完成动画闭包
        - parameter completion:             动画结束后的闭包
        */

        UIView.animateWithDuration(1, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: { () -> Void in
            //强制刷新
            self.view.layoutIfNeeded()
            }) { (_) -> Void in
                //发送通知
                NSNotificationCenter.defaultCenter().postNotificationName(HMZSwitchRootVCNotificationKey, object: nil)
        }
    }
    
    
    /// 子视图
    private lazy var backImageView: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    /// 头像
    private lazy var iconView: UIImageView = UIImageView()
    
    ///  欢迎台词
    private lazy var welcomeLabel: UILabel = {
        let l = UILabel()
        l.text = (HMZUserAccountViewModel.shareViewModel.userName ?? "") + "\n 欢迎回来, 有你的日子真好"
        l.textAlignment = .Center
        l.numberOfLines = 0
        l.font = UIFont.systemFontOfSize(20)
        return l
    }()
}
