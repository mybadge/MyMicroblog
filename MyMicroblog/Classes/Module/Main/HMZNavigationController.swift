//
//  HMZNavigationController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/14.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

class HMZNavigationController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //添加手势的代理，一旦自定义了返回按钮，系统的手势倒流就会取消，需要手动添加。
        interactivePopGestureRecognizer?.delegate = self
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
            if childViewControllers.count != 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .Plain, target: self, action: "back")
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func back() {
        navigationController?.popViewControllerAnimated(true)
    }
}
