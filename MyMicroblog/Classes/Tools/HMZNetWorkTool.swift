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

private let hostName = "https://api.weibo.com"
private let dataErrorDomain = "com.baidu.data.error"


class HMZNetWorkTool: AFHTTPSessionManager {
    static let sharedTools: HMZNetWorkTool = {
        let url = NSURL(string: hostName)!
        let instence = HMZNetWorkTool(baseURL: url)
        instence.responseSerializer.acceptableContentTypes?.insert("text/html")
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
    
    
}
