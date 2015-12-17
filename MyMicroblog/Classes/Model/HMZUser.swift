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
    case Other = 330
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
        {
            switch verified_type {
            case .None : return nil
            case .Personal : return UIImage(named: "avatar_vip")
            case .OrgEnterprice, .OrgMedia, .OrgWebsite: return UIImage(named: "avatar_enterprise_vip")
            case .Daren: return UIImage(named: "avatar_grassroot")
            default : return nil
            }
    }
    
    /// 会员等级 0-6
    var mbrank: Int = 0
    ///用户等级图片
    var mbrankImage: UIImage? {
        if mbrank > 0 && mbrank < 7 {
            return UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        return nil
    }
    /// 用户博客地址
    var url: String?
    /// 用户描述
    var des: String?
    /// 创建时间
    var created_at: String?
    var created_atStr: String?{
        let date = NSDate.sinaDate(created_at ?? "")
        return date?.fullDescription()
    }
    /// 用户头像 180 *180
    var avatar_large: String?
    var avatar_largeURL: NSURL? {
        return NSURL(string: avatar_large ?? "")
    }
    
    init(dict: [String: AnyObject]){
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "description" {
            des = value as? String
            return
        }
        super.setValue(value, forKey: key)
    }
    
    ///  过滤属性
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {   }
    
    override var description: String {
        let keys = ["id", "name", "created_at", "avatar_large"]
        return dictionaryWithValuesForKeys(keys).description
    }
}


/**
{
"id": 1885390645,
"idstr": "1885390645",
"class": 1,
"screen_name": "郝悦兴",
"name": "郝悦兴",
"province": "13",
"city": "1",
"location": "河北 石家庄",
"description": "著名学者、资深IT人士、诗人、伟大的革命先行者郝悦兴先生",
"url": "http://www.hao.today",
"profile_image_url": "http://tp2.sinaimg.cn/1885390645/50/5692417995/1",
"cover_image": "http://ww4.sinaimg.cn/crop.0.0.980.300/7060c735gw1e9d4chgkpaj20r808cq66.jpg",
"cover_image_phone": "http://ww1.sinaimg.cn/crop.0.0.640.640.640/a1d3feabjw1ecat4uqw77j20hs0hsacp.jpg",
"profile_url": "80902933",
"domain": "haoyuexing",
"weihao": "80902933",
"gender": "m",
"followers_count": 368,
"friends_count": 368,
"pagefriends_count": 0,
"statuses_count": 1061,
"favourites_count": 70,
"created_at": "Tue Dec 07 15:58:23 +0800 2010",
"following": true,
"allow_all_act_msg": false,
"geo_enabled": true,
"verified": false,
"verified_type": -1,
"remark": "",
"status_id": 3920861738378489,
"ptype": 0,
"allow_all_comment": true,
"avatar_large": "http://tp2.sinaimg.cn/1885390645/180/5692417995/1",
"avatar_hd": "http://ww3.sinaimg.cn/crop.0.0.640.640.1024/7060c735jw8eff0t3ko25j20hs0hswfj.jpg",
"verified_reason": "",
"verified_trade": "",
"verified_reason_url": "",
"verified_source": "",
"verified_source_url": "",
"follow_me": false,
"online_status": 0,
"bi_followers_count": 98,
"lang": "zh-cn",
"star": 0,
"mbtype": 2,
"mbrank": 4,
"block_word": 0,
"block_app": 0,
"credit_score": 80,
"user_ability": 0,
"urank": 22
},


*/
