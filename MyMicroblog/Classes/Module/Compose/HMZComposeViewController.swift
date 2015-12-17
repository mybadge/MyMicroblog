//
//  HMZComposeViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/17.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

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
    
    private func setupTitle() {
        
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
        
    }
}
