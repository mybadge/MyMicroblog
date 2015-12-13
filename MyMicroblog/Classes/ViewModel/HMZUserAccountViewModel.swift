//
//  HMZUserAccountViewModel.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/13.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

class HMZUserAccountViewModel: NSObject {
    
    override init() {
        super.init()
        account = HMZAccount.account()
    }
    
    var account: HMZAccount?
    
    /// 用户是否登录过
    var userLoginState: Bool {
        return account?.access_token != nil
    }
    /// 用户姓名
    var userName: String? {
        return account?.name
    }
    /// tokenID
    var token: String? {
        return account?.access_token
    }
    /// 头像Image
    var headImageURL: NSURL? {
        return NSURL(string: account?.avatar_large ?? "")
    }
   
}

extension HMZUserAccountViewModel {
    ///获取taken_Id
    func getAccessToken(code: String, finish: (error: NSError?) ->()){
        var param: [String: String] = [String: String]()
        param["client_id"] = HMZApiClient_id
        param["client_secret"] = HMZApiClient_secret
        param["grant_type"] = "authorization_code"
        param["code"] = code
        param["redirect_uri"] = HMZApiRedirect_uri
        
        HMZNetWorkTool.sharedTools.requestJSONDict(.POST, urlString: "oauth2/access_token", parameters: param) { (result, error) -> () in
            if error != nil {//如果错误不为空, 有错误
                finish(error: error)
                return
            }
            print(result)
            let account = HMZAccount(dict: result!)
            self.loadUserInfo(account, finished: { (error) -> () in
                finish(error: error)
            })
            //Optional(["access_token": 2.00qcxPXFWPjfiC9eefed557816UaRC, "remind_in": 157679999, "uid": 5072087372, "expires_in": 157679999])
            
        }
    }
    
    private func loadUserInfo(account: HMZAccount,finished: (error: NSError?) ->()) {
        let urlString = "2/users/show.json"
        //为了保险起见, 判断一下
        guard let access_token = account.access_token , userId = account.uid else{
            return
        }
        
        var param = [String: String]()
        param["access_token"] = access_token
        param["uid"] = userId
        
        HMZNetWorkTool.sharedTools.requestJSONDict(urlString: urlString, parameters: param) { (result, error) -> () in
            if (error != nil) {
                finished(error: error)
            }
            
            account.avatar_large = result!["avatar_large"] as? String
            account.name = result!["name"] as? String
            account.saveAccount()
            
            //print(result)
            /**
            //用户信息
            Optional(["friends_count": 156, "description": , "favourites_count": 6, "ptype": 0, "remark": , "name": 幻梦者8805, "statuses_count": 107, "id": 5072087372, "star": 0, "province": 100, "verified_source": , "profile_image_url": http://tp1.sinaimg.cn/5072087372/50/5690176295/1, "status": {
            "attitudes_count" = 0;
            "biz_feature" = 0;
            "comments_count" = 0;
            "created_at" = "Fri Dec 11 17:05:19 +0800 2015";
            "darwin_tags" =     (
            );
            favorited = 0;
            geo = "<null>";
            id = 3918911269681197;
            idstr = 3918911269681197;
            "in_reply_to_screen_name" = "";
            "in_reply_to_status_id" = "";
            "in_reply_to_user_id" = "";
            isLongText = 0;
            mid = 3918911269681197;
            mlevel = 0;
            "pic_urls" =     (
            );
            "reposts_count" = 0;
            source = "<a href=\"http://app.weibo.com/t/feed/419Wvc\" rel=\"nofollow\">\U672a\U901a\U8fc7\U5ba1\U6838\U5e94\U7528</a>";
            "source_allowclick" = 0;
            "source_type" = 1;
            text = "[\U9a6c\U4e0a\U6709\U5bf9\U8c61][\U5403\U5143\U5bb5][\U563b\U563b][\U54c8\U54c8][\U7231\U4f60][\U54fc]\Ud83d\Ude01\Ud83d\Ude33\Ud83d\Ude2d\Ud83d\Ude25";
            truncated = 0;
            userType = 0;
            visible =     {
            "list_id" = 0;
            type = 0;
            };
            }, "url": , "allow_all_comment": 1, "class": 1, "idstr": 5072087372, "verified": 0, "online_status": 0, "gender": m, "avatar_large": http://tp1.sinaimg.cn/5072087372/180/5690176295/1, "weihao": , "verified_trade": , "avatar_hd": http://ww3.sinaimg.cn/crop.0.0.640.640.1024/005xfXCQjw8eel0ylpy3wj30hs0hsmxp.jpg, "block_word": 0, "domain": , "verified_reason": , "location": 其他, "urank": 9, "user_ability": 0, "follow_me": 0, "verified_reason_url": , "bi_followers_count": 6, "lang": zh-cn, "profile_url": u/5072087372, "following": 0, "geo_enabled": 1, "allow_all_act_msg": 0, "screen_name": 幻梦者8805, "created_at": Sat Mar 15 17:28:27 +0800 2014, "city": 1000, "credit_score": 80, "mbtype": 0, "verified_type": -1, "followers_count": 19, "pagefriends_count": 1, "block_app": 0, "mbrank": 0, "cover_image_phone": http://ww2.sinaimg.cn/crop.0.0.640.640.640/a1d3feabjw1ecat8op0e1j20hs0hswgu.jpg, "verified_source_url": ])
            */
        }
    }
}
