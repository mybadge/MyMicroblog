//
//  HMZCommon.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/12.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

//swift 在同一个命名空间 下 所有的文件 和方法 以及属性 全局共享
//和OC中 pch文件类似  定义程序中 非常常用的方法 常量

/// 屏幕的宽
let screenW = UIScreen.mainScreen().bounds.width
/// 屏幕的高
let screenH = UIScreen.mainScreen().bounds.height
/// 主题颜色
let HMZThemeColor = UIColor.orangeColor()
/// appkey
let HMZApiClient_id = "2492369838"
/// appSecret
let HMZApiClient_secret = "47731e717d9338fbe53f46518f150eb1"
/// 回调地址
let HMZApiRedirect_uri = "http://www.baidu.com"
/// 错误提示
let HMZAppErrorTip = "哥正忙着呢.....一边玩去"
/// 选择控制器通知的Key
let HMZSwitchRootVCNotificationKey = "HMZSwitchRootVCNotificationKey"


///  获取随机颜色
func HMZRandomColor() ->UIColor{
    return UIColor(red: (CGFloat)(random() % 256) / 256.0, green: (CGFloat)(random() % 256) / 256.0, blue: (CGFloat)(random() % 256) / 256.0, alpha: 1)
}

///  获取沙盒中文件绝对路径 根据相对路径
///  - parameter path: 在沙盒中的相对路径
///  - returns: 沙盒中的绝对路径
func HMZGetDocumentDicrectoryPathWith(path:String) ->String {
    return (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString).stringByAppendingPathComponent(path)
}






/// 输出日志
///
/// - parameter message:  日志消息
/// - parameter logError: 错误标记，默认是 false，如果是 true，发布时仍然会输出
/// - parameter file:     文件名
/// - parameter method:   方法名
/// - parameter line:     代码行数
func printLog<T>(message: T,
    logError: Bool = false,
    file: String = __FILE__,
    method: String = __FUNCTION__,
    line: Int = __LINE__)
{
    if logError {
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    } else {
        //#if DEBUG
            print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        //#endif
    }
}