//
//  String+RegEx.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/16.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import Foundation

extension String {
    //元组类型
    func linkText() ->(url: String?,text: String?){
        //匹配方法
        let pattern = "<a href=\"(.*?)\" .*?>(.*?)</a>"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        //调用 正则表达式的核心方法之一
        guard let result = regex.firstMatchInString(self, options: [], range: NSRange(location: 0, length:characters.count)) else {
            print("匹配方案有误")
            return (nil,nil)
        }
        
        let range1 = result.rangeAtIndex(1)
        let subStr1 = (self as NSString).substringWithRange(range1)
        
        let range2 = result.rangeAtIndex(2)
        let subStr2 = (self as NSString).substringWithRange(range2)
        
        print(self + "------" + subStr1 + "---------" + subStr2)
        return (subStr1,subStr2)
    }
}