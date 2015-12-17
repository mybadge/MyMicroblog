//
//  HMZComposeViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/17.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SnapKit

class HMZComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @objc private func compose() {
        print(__FUNCTION__)
    }
}

extension HMZComposeViewController {
    private func setupUI() {
        view.backgroundColor = HMZRandomColor()
        setupNav()
    }
    private func setupNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: "cancel")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .Plain, target: self, action: "compose")
        navigationItem.rightBarButtonItem?.enabled = false
        //设置title
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        navigationItem.titleView = v
        let weiboLabel = UILabel(title: "发微博", color: UIColor.darkGrayColor(), fontSize: 17)
        let nameLabel = UILabel(title: HMZUserAccountViewModel.shareViewModel.userName ?? "", color: UIColor.lightGrayColor(), fontSize:14)
        v.addSubview(weiboLabel)
        v.addSubview(nameLabel)
        weiboLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(v.snp_centerX)
            make.top.equalTo(v.snp_top)
        }
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(v.snp_centerX)
            make.bottom.equalTo(v.snp_bottom)
        }
    }
}
