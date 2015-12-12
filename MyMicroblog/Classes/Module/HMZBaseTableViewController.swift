//
//  HMZBaseTableViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/12.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

class HMZBaseTableViewController: UITableViewController {

    /// 用户登录标识
    var userLoginState = false
    
    override func loadView() {
        if userLoginState {
            //登录成功 跳到首页
            super.loadView()
        }else{
            //未登录  跳到访客视图
            
        }
    }
   

}
