//
//  HMZEmoticonTextView.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/17.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

class HMZEmoticonTextView: UITextView {

    ///  返回文本框上所有字符串
    func fullText() ->String {
        let attrText = attributedText
        //遍历属性文本的所有属性
        var strM = String()
        attrText.enumerateAttributesInRange(NSRange(location: 0, length: attrText.length), options: []) { (dict, range, _) -> Void in
            if let attachment = dict["NSAttachment"] as? HMZEmoticonAttachment {
                //将表情图片转换为表情文字  笑哈哈图片 [笑哈哈文本]
                strM += attachment.chs ?? ""
            } else {
              let str = (self.text as NSString).substringWithRange(range)
                strM += str
            }
        }
        
        return strM
    }
    
    ///点击表情键盘,插入选中表情
    func insertTextWithEmoticon(em: HMZEmoticon) {
        //点击了空表情
        if em.isEmpty {
            return
        } else if em.isDelete {
            //调用系统的删除字符的方法,删除表情
            deleteBackward()
            return
        } else if em.code != nil {
            //文本替换,把emoji中的16进制转化为表情字符串
            replaceRange(selectedTextRange!, withText: em.emojiStr ?? "")
            return
        }
        
        //根据文本框上原有的属性文字 创建可变的属性字符串对象,以遍进行属性字符串的拼接
        let strM = NSMutableAttributedString(attributedString: attributedText)
        //储存光标位置
        let range = selectedRange
        //把表情图片添加到表情附件中
        let attach = HMZEmoticonAttachment()
        //获取富文本
        let attrStr = attach.imageToAttrString(em, font: font!)
        //把当前选中位置替换为富文本
        strM.replaceCharactersInRange(selectedRange, withAttributedString: attrStr)
        //把拼接好的整个富文本赋值给textView的 属性文字中
        attributedText = strM
        //更新光标位置(因为添加了一个字符,光标位置应该加1)
        selectedRange = NSRange(location: range.location + 1, length: 0)
    }

}
