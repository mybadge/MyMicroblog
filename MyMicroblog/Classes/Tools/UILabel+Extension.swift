//
//  UILabel+Extension.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/14.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(title: String, color: UIColor = UIColor.darkGrayColor(), fontSize: CGFloat = 15, margin: CGFloat = 0){
        self.init()
        text = title
        textColor = color
        font = UIFont.systemFontOfSize(fontSize)
        numberOfLines = 0
        textAlignment = .Center
        
        if margin > 0 {
            preferredMaxLayoutWidth = screenW - margin * 2
            textAlignment = .Left
        }
        
        sizeToFit()
    }
}
