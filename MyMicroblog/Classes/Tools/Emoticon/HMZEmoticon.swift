//
//  HMZEmoticon.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/17.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

class HMZEmoticon: NSObject {
    ///分组的文件夹名称 用来拼接图片路径
    var id: String?
    ///表情字符串  发送给服务器
    var chs: String?
    ///表情图片 本地显示用
    var png: String?
    ///本地图片地址
    var image: UIImage? {
        let path = NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + "\(id ?? "")" + "/\(png ?? "")"
        return UIImage(contentsOfFile: path)
    }
    
    ///Emoji 表情的十六进制的字符串
    var code: String?
    ///计算性属性
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





