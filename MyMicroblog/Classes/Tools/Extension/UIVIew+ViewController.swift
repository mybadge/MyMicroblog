//
//  UIVIew+ViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/14.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

extension UIView {
    ///  遍历响应者对象获取导航控制器对象
    func getNavController() ->HMZNavigationController?{
        //遍历响应者链条 获取导航视图控制器
        //获取视图的下一个响应者
        var next = nextResponder()
        repeat {
            if let nextObject = next as? HMZNavigationController {
                return nextObject
            }
            //获取下一个响应者对象
            next = next?.nextResponder()
        } while (next != nil)
        
        return nil
    }
}
