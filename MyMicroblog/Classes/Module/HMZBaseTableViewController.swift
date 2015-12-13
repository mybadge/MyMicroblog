//
//  HMZBaseTableViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/12.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

class HMZBaseTableViewController: UITableViewController,HMZVisitorLoginViewDelegate {
    
    /// 用户登录标识
    var userLoginState = HMZUserAccountViewModel().userLoginState
    
    var visitorLoginView: HMZVisitorLoginView?
    
    override func loadView() {
        if userLoginState {
            //登录成功 跳到首页
            super.loadView()
        }else{
            //未登录  跳到访客视图
            setupVisitorLoginView()
        }
    }
    
    func setupVisitorLoginView(){
        visitorLoginView = HMZVisitorLoginView()
        
        view = visitorLoginView
        
        //设置代理
        visitorLoginView?.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: "userWillLogin")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "userWillRegister")
    }
    
    func userWillLogin() {
        print(__FUNCTION__)
        
        let nav = UINavigationController(rootViewController: HMZOAuthViewController())
        //一般像登录,注册这类的和程序的主题框架不同的控制器,要Modal出来.
        presentViewController(nav, animated: true, completion: nil)
    }
    
    func userWillRegister() {
        print(__FUNCTION__)
    }
}
