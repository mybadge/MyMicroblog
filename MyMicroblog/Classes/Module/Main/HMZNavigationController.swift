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
        interactivePopGestureRecognizer?.delegate = self
//        let swipe = UISwipeGestureRecognizer(target: self, action: "back")
//        swipe.direction = .Left
//        view.addGestureRecognizer(swipe)
//        navigationBar.setBackgroundImage(<#T##backgroundImage: UIImage?##UIImage?#>, forBarMetrics: <#T##UIBarMetrics#>)
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        //print("viewController.childViewControllers.count=\(childViewControllers.count)")
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
