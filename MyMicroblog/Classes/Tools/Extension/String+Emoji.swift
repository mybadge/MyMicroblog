//
//  String+Emoji.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/25.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import Foundation

extension String {
    ///  根据16进制转化成字符串
    func emojiStr() -> String {
        let scanner = NSScanner(string: self)
        //将扫描字符串的结果 输出到某一个地址下
        var value: UInt32 = 0
        scanner.scanHexInt(&value)
        //将十六进制的数据转换为 unicode 编码字符
        let c = Character(UnicodeScalar(value))
        return "\(c)"
    }
}