//
//  HMZStatusViewModel.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/15.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

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
            var list = [HMZStatus]()
            
            for dict in arrayList {
                list.append(HMZStatus(dict: dict))
            }
            //缓存图片数据
            cacheStatusImage(list, finish: finish)
        }
    }
    
    //下载单张图片
    class func cacheStatusImage(list: [HMZStatus], finish: (statuses: [HMZStatus]?) ->()){
        if list.count == 0 {
            finish(statuses: list)
            return
        }
        //实例化群组任务
        let group = dispatch_group_create()
        
        for status in list {
            //单张图片下载  开始异步任务之前 先进入群组  有入组 就一定要匹配一个 出组
            if let urls = status.pictureURLs where urls.count == 1 {
                dispatch_group_enter(group)//入组
                SDWebImageManager.sharedManager().downloadImageWithURL(urls.first, options: [], progress: nil, completed: { (_, _, _, _, _) -> Void in
                    //出组
                    dispatch_group_leave(group)
                })
            }
        }
        //开始 统一回调
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            finish(statuses: list)
        }
    }
    
    
    
    ///  转发一条微博 https://api.weibo.com/2/statuses/repost.json
    class func repostStatus(id:Int, finish:(result: Bool) ->()) {
        let urlString = "2/statuses/repost.json"
        guard let token  = HMZUserAccountViewModel.shareViewModel.token else{
            SVProgressHUD.showErrorWithStatus("您还未登录,请先登录")
            return
        }
        var param: [String: String] = [String: String]()
        param["access_token"] = token
        param["id"] = "\(id)"
        HMZNetWorkTool.sharedTools.requestJSONDict(HTTPRequestMethod.POST, urlString: urlString, parameters: param) { (result, error) -> () in
            if error != nil {
                printLog("数据类型有误")
                finish(result: false)
                return
            }
            finish(result: true)
        }
    }
    
}
