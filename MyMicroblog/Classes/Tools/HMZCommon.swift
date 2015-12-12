//
//  HMZCommon.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/12.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

let HMZThemeColor = UIColor.orangeColor()


func HMZRandomColor() ->UIColor{
    return UIColor(red: (CGFloat)(random() % 256) / 256.0, green: (CGFloat)(random() % 256) / 256.0, blue: (CGFloat)(random() % 256) / 256.0, alpha: 1)
}