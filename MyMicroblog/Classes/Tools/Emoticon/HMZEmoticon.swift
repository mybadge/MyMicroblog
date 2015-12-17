//
//  HMZEmoticon.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/17.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

class HMZEmoticon: NSObject {
    //分组的文件夹名称 用来拼接图片路径
    var id: String?
    //表情字符串  发送给服务器
    var chs: String?
    //表情图片 本地显示用
    var png: String?
    //本地图片地址
    var imagePath: String? {
        let path = NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + "\(id ?? "")" + "/\(png ?? "")"
        return path
    }
    
    //Emoji 表情的十六进制的字符串
    var code: String?
    //计算性属性
    var emojiStr: String? {
        return (code ?? "").emojiStr()
    }
    
    var isDelete: Bool = false
    var isEmpty: Bool = false
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    //增加删除表情的实例化方法
    init(isDelete: Bool) {
        self.isDelete = isDelete
        super.init()
    }
    
    //增加空表情的实例化方法
    init(isEmpty: Bool) {
        self.isEmpty = isEmpty
        super.init()
    }
    
    //过滤
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    //重写description 属性
    override var description: String {
        let keys = ["chs","png","code"]
        return dictionaryWithValuesForKeys(keys).description
    }
}





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