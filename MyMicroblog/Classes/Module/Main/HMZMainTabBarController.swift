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
        addChildVC(HMZHomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildVC(HMZMessageViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildVC(HMZDiscoverViewController(), title: "发现", imageName: "tabbar_discover")
        addChildVC(HMZProfileViewController(), title: "我", imageName: "tabbar_profile")
    }

    func addChildVC(vc: UIViewController, title: String, imageName: String) {
        //先创建一个导航控制器
        let nav = HMZNavigationController(rootViewController: vc)
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        addChildViewController(nav)
        //设置随机颜色
        //vc.view.backgroundColor = HMZRandomColor()
    }
}
