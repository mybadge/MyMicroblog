//
//  UIButton+Extension.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/14.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

/// 给UIButton扩展方法
/// 分类中不能够添加指定的构造方法
///不能够添加存储型属性  只能够添加只读属性 和 方法
extension UIButton {
    ///  快速创建btn方法
    ///
    ///  - parameter title:            title 标题
    ///  - parameter backgroundImage:  backgroundImage 背景图片名称
    ///  - parameter color:            color 字体颜色
    ///  - parameter fontSize:         fontSize 字体大小
    ///  - parameter isNeedHighighted: isNeedHighighted 是否需要高亮状态
    ///  - parameter imageName:        imageName 图片按钮
    convenience init(title: String, backgroundImage: String?, color: UIColor, fontSize: CGFloat = 15, isNeedHighighted: Bool = false, imageName: String? = nil){
        self.init()
        setTitle(title, forState: .Normal)
        
        if backgroundImage != nil {
            setBackgroundImage(UIImage(named: backgroundImage!), forState: .Normal)
            
            if isNeedHighighted {
                setBackgroundImage(UIImage(named: backgroundImage! + "_highlighted"), forState: .Highlighted)
            }
        }
        
        if imageName != nil {
            setImage(UIImage(named: imageName!), forState: .Normal)
            
            if isNeedHighighted {
                setImage(UIImage(named: imageName! + "_highlighted"), forState: .Highlighted)
            }
            titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        }
        
        setTitleColor(color, forState: .Normal)
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        
        sizeToFit()
    }
    
    
    ///  快速创建对象
    ///  - parameter imageName:       设置图片
    ///  - parameter backgroundImage: 设置背景图片
    convenience init(imageName: String, backgroundImage: String?){
        self.init()
        setImage(UIImage(named: imageName), forState: .Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        
        if backgroundImage != nil {
            setBackgroundImage(UIImage(named: backgroundImage!), forState: .Normal)
            setBackgroundImage(UIImage(named: backgroundImage! + "_highlighted"), forState: .Highlighted)
        }
        sizeToFit()
    }
    
}