//
//  HMZTabBarController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/12.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

class HMZTabBarController: UITabBarController {
    
    let mainTabBar = HMZMainTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //kvc赋值
        setValue(mainTabBar, forKey: "tabBar")
        
        //初始化子控制器
        setupChildVC()
    }
}

extension HMZTabBarController{
    ///初始化子控制器
    func setupChildVC(){
        addChildVC(HMZHomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildVC(HMZMessageViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildVC(HMZDiscoverViewController(), title: "发现", imageName: "tabbar_discover")
        addChildVC(HMZProfileViewController(), title: "我", imageName: "tabbar_profile")
    }

    func addChildVC(vc: UIViewController, title: String, imageName: String) {
        //先创建一个导航控制器
        let nav = UINavigationController(rootViewController: vc)
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        addChildViewController(nav)
        //设置随机颜色
        //vc.view.backgroundColor = HMZRandomColor()
    }
}
