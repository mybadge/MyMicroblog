//
//  HMZAccount.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/13.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
/// 账号模型
class HMZAccount: NSObject, NSCoding {
    //Optional(["access_token": 2.00qcxPXFWPjfiC9eefed557816UaRC, "remind_in": 157679999, "uid": 5072087372, "expires_in": 157679999])
    /// 用于调用access_token，接口获取授权后的access token。
    var access_token:String?
    
    /// 过期时间 access_token的生命周期，单位是秒数
    var expires_in:NSTimeInterval = 0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
            //print("expires_date=\(expires_date)=======expires_in=\(expires_in)")
        }
    }
    
    ///计算型属性 计算token失效的日期
    ///开发者账号的有效期 是5年
    ///普通用户的有效期 是 3天  未审核通过的token的有效期 是1天
    var expires_date: NSDate?
    
    /// 当前授权用户的UID
    var uid:String?
    
    ///友好显示名称
    var name: String?
    ///用户头像地址（大图），180×180像素
    var avatar_large: String?
    
    ///  字典转模型
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    ///  过滤
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {  }
    
    ///  重写description
    override var description: String {
        let keys = ["access_token", "expires_date", "uid", "name", "avatar_large"]
        return dictionaryWithValuesForKeys(keys).description
    }
    
    ///  获取账号信息,由于这个模型整个程序要经常使用,最好放到内存中,以减少IO操作
    class func account() ->HMZAccount? {
        let path = HMZGetDocumentDicrectoryPathWith("account.plist")
        if let account = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? HMZAccount {
            //判断账号是否过期
            
            /**
            case OrderedAscending 上升
            case OrderedSame 相等
            case OrderedDescending 下降
            */
            print("判断日期expires_date与当前日期的判断 =\(account.expires_date?.compare(NSDate()) == NSComparisonResult.OrderedDescending)")
            if account.expires_date?.compare(NSDate()) == NSComparisonResult.OrderedDescending {
                return account
            }
        }
        
        return nil
    }
    
    ///  保存到沙盒
    func saveAccount() {
        let path = HMZGetDocumentDicrectoryPathWith("account.plist")
        NSKeyedArchiver.archiveRootObject(self, toFile: path)
    }
    
    ///  归档
    func encodeWithCoder(encoder: NSCoder){
        encoder.encodeObject(access_token, forKey: "access_token")
        encoder.encodeObject(expires_date,forKey: "expires_date")
        encoder.encodeObject(uid, forKey: "uid")
        encoder.encodeObject(name, forKey: "name")
        encoder.encodeObject(avatar_large, forKey: "avatar_large")
    }
    
    ///  解档
    required init?(coder decoder: NSCoder) {
        access_token = decoder.decodeObjectForKey("access_token") as? String
        expires_date = decoder.decodeObjectForKey("expires_date") as? NSDate
        uid  = decoder.decodeObjectForKey("uid") as? String
        name = decoder.decodeObjectForKey("name") as? String
        avatar_large = decoder.decodeObjectForKey("avatar_large") as? String
    }
}



