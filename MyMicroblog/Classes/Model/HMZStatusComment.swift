//
//  HMZStatusComment.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/18.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

class HMZStatusComment: NSObject {
    /**
     返回值字段	字段类型	字段说明
     created_at	string	评论创建时间
     id	int64	评论的ID
     text	string	评论的内容
     source	string	评论的来源
     user	object	评论作者的用户信息字段 详细
     mid	string	评论的MID
     idstr	string	字符串型的评论ID
     status	object	评论的微博信息字段 详细
     reply_comment	object	评论来源评论，当本评论属于对另一评论的回复时返回此字段
     */
     
     ///评论创建时间
    var created_at:	String?
    var created_atStr: String? {
        return NSDate.sinaDate(created_at ?? "")?.commentTime()
    }
    
    /// 评论的ID
    var id: Int = 0
    /// 评论的内容
    var text: String?
    /// 评论的来源
    var source: String?
    /// 评论作者的用户信息字段 详细
    var user: HMZUser?
    /// 评论的MID
    var mid: String?
    /// 字符串型的评论ID
    var idstr: String?
    /// 评论的微博信息字段 详细
    var status:	HMZStatus?
    //var reply_comment	object	评论来源评论，当本评论属于对另一评论的回复时返回此字段
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "user" {
            if let dict = value as? [String: AnyObject] {
                user = HMZUser(dict: dict)
            }
            return
        } else if key == "status" {
            if let dict = value as? [String: AnyObject] {
                status = HMZStatus(dict: dict)
            }
            return
        }
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {  }
    
    override var description: String {
        let keys = ["created_at", "text", "idstr", "source"]
        return "HMZStatusComment = " + dictionaryWithValuesForKeys(keys).description
    }
    
}
