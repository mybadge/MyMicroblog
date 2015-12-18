//
//  HMZStatusCommentViewModel.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/18.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SVProgressHUD

class HMZStatusCommentViewModel: NSObject {
    ///  请求评论数据
    ///
    ///  - parameter id:     需要查询的微博ID
    ///  - parameter count:
    ///  - parameter cursor:
    ///  - parameter finish: 回掉
    class func loadData(id:Int, count: Int = 50, cursor: Int = 0, finish: (list: [HMZStatusComment]?) ->()){
        let urlString = "2/comments/show.json"
        guard let account  = HMZUserAccountViewModel.shareViewModel.account else{
            SVProgressHUD.showErrorWithStatus("您还未登录,请先登录")
            return
        }
        var param: [String: String] = [String: String]()
        param["access_token"] = account.access_token
        param["id"] = "\(id)"
        param["uid"] = account.uid
        param["count"] = "\(count)"
        
        param["cursor"] = "\(cursor)"
        
        HMZNetWorkTool.sharedTools.requestJSONDict(urlString: urlString, parameters: param) { (result, error) -> () in
            if error != nil {
                printLog("评论数据类型有误")
                finish(list: nil)
                return
            }
            //print(result)
            //取出数组中的user 字典,并且是一个嵌套数组字典(数组->字典->数组->字典)
            guard let arrayList = result!["comments"] as? [[String: AnyObject]] else {
                finish(list: nil)
                return
            }
            var list = [HMZStatusComment]()
            
            for dict in arrayList {
                list.append(HMZStatusComment(dict: dict))
            }
            //成功返回数据
            finish(list: list)
        }
    }
}
