//
//  HMZUser.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/14.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

enum HMZUserVerifiedType: Int{
    /// 没有任何认证
    case None = -1
    /// 个人认证
    case Personal = 0
    /// 企业官方：CSDN、EOE、搜狐新闻客户端
    case OrgEnterprice = 2
    /// 媒体官方：程序员杂志、苹果汇
    case OrgMedia = 3
    /// 网站官方：猫扑
    case OrgWebsite = 5
    /// 微博达人
    case Daren = 220
}

class HMZUser: NSObject {
    /// 用户ID
    var id = 0
    /// 用户昵称
    var name: String?
    /// 头像url
    var profile_image_url: String?
    
    var headImageURL: NSURL? {
        return NSURL(string: profile_image_url ?? "")
    }
    
    /// 认证类型
    var verified_type: HMZUserVerifiedType = .None
    ///认真类型图片
    var verified_type_image: UIImage?
  //      {
//        switch verified_type {
//        case -1 : return nil
//        case 0 : return UIImage(named: "avatar_vip")
//        case 2,3,5: return UIImage(named: "avatar_enterprise_vip")
//        case 220: return UIImage(named: "avatar_grassroot")
//        default : return nil
//        }
 //   }
    
    /// 会员等级 0-6
    var mbrank: Int = 0
    ///用户等级图片
    var mbrankImage: UIImage? {
        if mbrank > 0 && mbrank < 7 {
            return UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        return nil
    }
    
    
    init(dict: [String: AnyObject]){
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    ///  过滤属性
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {   }
}
