//
//  HMZStatusViewModel.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/15.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SVProgressHUD

class HMZStatusViewModel: NSObject {
    class func loadData(sinceId: Int, maxId: Int, finish: (statuses: [HMZStatus]?) ->()){
        let urlString = "2/statuses/home_timeline.json"
        guard let token  = HMZUserAccountViewModel.shareViewModel.token else{
            SVProgressHUD.showErrorWithStatus("您还未登录,请先登录")
            return
        }
        var param: [String: String] = [String: String]()
        param["access_token"] = token
        if sinceId > 0 {
            param["since_id"] = "\(sinceId)"
        }
        if maxId > 0 {
            param["max_id"] = "\(maxId)"
        }
        HMZNetWorkTool.sharedTools.requestJSONDict(urlString: urlString, parameters: param) { (result, error) -> () in
            if error != nil {
                printLog("数据类型有误")
                finish(statuses: nil)
                return
            }
            
            //取出数组中的Statuses 字典,并且是一个嵌套数组字典(数组->字典->数组->字典)
            guard let arrayList = result!["statuses"] as? [[String: AnyObject]] else {
                finish(statuses: nil)
                return
            }
//            //printLog(arrayList[0])
            var list = [HMZStatus]()
            
            for dict in arrayList {
                list.append(HMZStatus(dict: dict))
            }
            //成功返回数据
            finish(statuses: list)
        }
    }
}
