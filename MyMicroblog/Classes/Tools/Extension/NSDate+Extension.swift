//
//  NSDate+Extension.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/16.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import Foundation

extension NSDate {
    class func sinaDate(dateString: String) ->NSDate? {
        //转换日期字符串
        let df = NSDateFormatter()
        df.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        //设置本地化标示符  真机一定需要指定本地标示符  否则无法转化
        df.locale = NSLocale(localeIdentifier: "en")
        //转化为日期对象
        return df.dateFromString(dateString)
    }
    
    
    /**
     刚刚(一分钟内)
     X分钟前(一小时内)
     X小时前(当天)
     
     昨天 HH:mm(昨天)
     MM-dd HH:mm(一年内)
     yyyy-MM-dd HH:mm(更早期)
     NSCelander  日历对象  提供了非常丰富的日期处理函数
     */
    func fullDescription() ->String {
        //1.获取需要比较的时间和当前时间的间隔
        let cal = NSCalendar.currentCalendar()
        if cal.isDateInToday(self) {
            //当天
            let delta = Int(NSDate().timeIntervalSinceDate(self))
            if delta < 60 {
                return "刚刚"
            }else if delta < 60 * 60 {
                return "\(delta / 60)分钟前"
            }else {
                return "\(delta / 3600)小时前"
            }
        } else {
            //实例化 日期格式化对象
            let df = NSDateFormatter()
            let common = " HH:mm"
            if cal.isDateInYesterday(self) {
                df.dateFormat = "昨天" + common
            } else {
                let result = cal.components(.Year, fromDate: self, toDate: NSDate(), options: [])
                if result.year == 0 {
                    df.dateFormat = "MM-dd" + common
                } else {
                    df.dateFormat = "yyyy-MM-dd" + common
                }
            }
            return df.stringFromDate(self)
        }
    }
    
    ///  评论时间显示格式
    func commentTime() ->String {
        let df = NSDateFormatter()
        df.dateFormat = "MM-dd HH:mm"
        return df.stringFromDate(self)
    }
    
}