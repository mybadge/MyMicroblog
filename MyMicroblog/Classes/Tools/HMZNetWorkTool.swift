//
//  HMZNetWorkTool.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/13.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import AFNetworking

//swift 中枚举可定义任何类型
enum HTTPRequestMethod: String{
    case POST = "POST"
    case GET = "GET"
}

private let hostName = "https://api.weibo.com/"
private let dataErrorDomain = "com.baidu.data.error"


class HMZNetWorkTool: AFHTTPSessionManager {
    static let sharedTools: HMZNetWorkTool = {
        let url = NSURL(string: hostName)!
        let instence = HMZNetWorkTool(baseURL: url)
        instence.responseSerializer.acceptableContentTypes?.insert("text/html")
        instence.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return instence
    }()
    
    
    //    func request(method: HTTPRequestMethod, URLString: String, parameters: AnyObject?, finished: (result: AnyObject?, error: NSError?)->()) {
    //        let success = {
    //            (task: NSURLSessionDataTask, result: AnyObject?) ->() in
    //            finished(result: result, error: nil)
    //        }
    //        let failure = {
    //            (task: NSURLSessionDataTask?, error: NSError) ->() in
    //            print(error)
    //            finished(result: nil, error: error)
    //        }
    //
    //        if method == .GET {
    //            GET(URLString, parameters: parameters, success: success, failure: failure)
    //        }else{
    //            POST(URLString, parameters: parameters, success: success, failure: failure)
    //        }
    //    }
    
    ///  基于核心网络框架的核心方法 进行封装  以后所有的网络请求 都走这个方法
    ///  默认是调用GET 方法, 只有第一个参数写上 .POST,才会调用POST方法
    func requestJSONDict(method : HTTPRequestMethod = .GET, urlString: String, parameters: [String: AnyObject]?, finished: (result:[String: AnyObject]?, error: NSError?) ->()) {
        if method == .GET {//默认是GET
            GET(urlString, parameters: parameters, success: { (_, result) -> Void in
                if let dict = result as? [String: AnyObject] {
                    finished(result: dict, error: nil)
                    return
                }else{
                    //如果程序走到这里  成功回调的结果 无法转换为字典形式的数据
                    let error = NSError(domain: dataErrorDomain, code: -10000, userInfo: [NSLocalizedDescriptionKey : "数据格式错误"])
                    finished(result: nil, error: error)
                }
                
                
                }, failure: { (_, error: NSError) -> Void in
                    print(error)
                    finished(result: nil, error: error)
            })
        }else{//是POST
            POST(urlString, parameters: parameters, success: { (_, result) -> Void in
                if let dict = result as? [String: AnyObject] {
                    finished(result: dict, error: nil)
                }else{
                    //如果程序走到这里  成功回调的结果 无法转换为字典形式的数据
                    let error = NSError(domain: dataErrorDomain, code: -10000, userInfo: [NSLocalizedDescriptionKey : "数据格式错误"])
                    finished(result: nil, error: error)
                }

            
                }, failure: { (_, error: NSError) -> Void in
                    print(error)
                    finished(result: nil, error: error)
            })
        }
    }
    
}
