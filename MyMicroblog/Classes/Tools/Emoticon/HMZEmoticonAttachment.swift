//
//  HMZEmoticonAttachment.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/17.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
/// 自定义表情附件类,添加了一个图片名称属性
class HMZEmoticonAttachment: NSTextAttachment {

    /// 表情图片的文本
    var chs: String?
    ///  根据表情模型和字体大小把图片变成富文本
    func imageToAttrString(em: HMZEmoticon, font: UIFont) ->NSAttributedString {
        //存储表情图片的名称,新浪微博的服务器存的是这个字符串,不会存具体图片的
        chs = em.chs
        //把要转换的图片对象 赋值给附件对象中的image属性
        image = em.image
        
        //获取文本的行高
        let lineHeight = font.lineHeight
        //设置图片转成富文本后的bound大小
        bounds = CGRect(x: 0, y: -4, width: lineHeight, height: lineHeight)
        
        //根据附件内容 创建一个可变的属性字符串对象
        let attrText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: self))
        //给富文本添加font属性
        attrText.addAttribute(NSFontAttributeName, value: font, range: NSRange(location: 0, length: 1))
        return attrText
    }
}
