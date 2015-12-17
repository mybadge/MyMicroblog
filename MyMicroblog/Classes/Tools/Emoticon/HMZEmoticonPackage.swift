//
//  HMZEmoticonPackage.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/17.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
/**
每隔20个按钮需要一个删除按钮
页面表情不足21个需要补足空表情
点击分组跳转到指定分组起始位置
*/
class HMZEmoticonPackage: NSObject {
    //表情模型数组
    lazy var emoticons = [HMZEmoticon]()
    var id: String?
    var group_name_cn:String?
    
    init(id:String, group_name_cn:String, array:[[String: String]]) {
        self.id = id
        self.group_name_cn = group_name_cn
        super.init()
        
        var index:Int = 0
        for item in array {
            let e = HMZEmoticon(dict: item)
            e.id = id
            emoticons.append(e)
            index++
            
            if index == 20 {
                emoticons.append(HMZEmoticon(isDelete: true))
                index = 0
            }
        }
        
        insertEmptyEmoticon()
    }
    
    ///判断每页是否有21个表情  如果不足21个 需要补足空表情
    private func insertEmptyEmoticon() {
        //判断是否需要添加空表情
       let delta = emoticons.count % 21
        if delta == 0 {
            return
        }
        //循环添加空表情
        for _ in delta..<20 {
            //添加空表情
            let e = HMZEmoticon(isEmpty: true)
            emoticons.append(e)
        }
        emoticons.append(HMZEmoticon(isDelete: true))
    }
}
