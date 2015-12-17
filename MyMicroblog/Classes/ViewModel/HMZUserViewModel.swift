//
//  HMZUserViewModel.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/17.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SVProgressHUD

class HMZUserViewModel: NSObject {
    
    /// int	单页返回的记录条数，默认为50，最大不超过200。
    //cursor 返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0
    class func loadData(count: Int = 50, cursor: Int = 0, finish: (list: [HMZUser]?) ->()){
        let urlString = "2/friendships/friends.json"
        guard let account  = HMZUserAccountViewModel.shareViewModel.account else{
            SVProgressHUD.showErrorWithStatus("您还未登录,请先登录")
            return
        }
        var param: [String: String] = [String: String]()
        param["access_token"] = account.access_token
        param["uid"] = account.uid
        param["count"] = "\(count)"
        
        param["cursor"] = "\(cursor)"
        
        HMZNetWorkTool.sharedTools.requestJSONDict(urlString: urlString, parameters: param) { (result, error) -> () in
            if error != nil {
                printLog("数据类型有误")
                finish(list: nil)
                return
            }
            
            //取出数组中的user 字典,并且是一个嵌套数组字典(数组->字典->数组->字典)
            guard let arrayList = result!["users"] as? [[String: AnyObject]] else {
                finish(list: nil)
                return
            }
            //            //printLog(arrayList[0])
            var list = [HMZUser]()
            
            for dict in arrayList {
                list.append(HMZUser(dict: dict))
            }
            //成功返回数据
            finish(list: list)
        }
    }
}
