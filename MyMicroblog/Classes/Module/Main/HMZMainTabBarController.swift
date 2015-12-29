//
//  HMZMainTabBarController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/12.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

class HMZMainTabBarController: UITabBarController {
    
    let mainTabBar = HMZMainTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //kvc赋值
        setValue(mainTabBar, forKey: "tabBar")
        mainTabBar.composeBtn.addTarget(self, action: "composeDidButtonClick", forControlEvents: .TouchUpInside)
        //mainTabBar.delegate = self
        //初始化子控制器
        setupChildVC()
        
    }
    
    @objc private func composeDidButtonClick() {
        print("composeClick")
        let nav = HMZNavigationController(rootViewController: HMZComposeViewController())
        presentViewController(nav, animated: true, completion: nil)
    }
}

extension HMZMainTabBarController{
    ///初始化子控制器
    func setupChildVC(){
        addChildVC(HMZHomeViewController(), title: "首页", imageName: "tabbar_home", index: 0)
        addChildVC(HMZMessageViewController(), title: "消息", imageName: "tabbar_message_center", index: 1)
        addChildVC(HMZDiscoverViewController(), title: "发现", imageName: "tabbar_discover", index: 2)
        addChildVC(HMZProfileViewController(), title: "我", imageName: "tabbar_profile", index: 3)
    }
    
    func addChildVC(vc: UIViewController, title: String, imageName: String, index: Int) {
        //先创建一个导航控制器
        let nav = HMZNavigationController(rootViewController: vc)
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.tag = index
        addChildViewController(nav)
    }
}

extension HMZMainTabBarController {
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        print("tag=\(item.tag)")
        var index = 0;
        for subView in tabBar.subviews {
            if subView.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                if item.tag == index {
                    for sub in subView.subviews {
                        if sub.isKindOfClass(NSClassFromString("UITabBarSwappableImageView")!) {
                            sub.transform = CGAffineTransformMakeScale(0.6, 0.6)
                            UIView.animateWithDuration(0.1, delay: 0.1, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.5, options: [], animations: { () -> Void in
                                sub.transform = CGAffineTransformIdentity
                                }, completion: nil)
                        }
                    }
                }
                index++
            }
        }
    }
}
