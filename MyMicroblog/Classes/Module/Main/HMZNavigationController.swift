//
//  HMZNavigationController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/14.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

class HMZNavigationController: UINavigationController {

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if viewController.childViewControllers.count != 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: "back")
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func back() {
        navigationController?.popViewControllerAnimated(true)
    }
}
