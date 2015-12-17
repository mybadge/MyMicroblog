//
//  HMZEmoticonManager.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/17.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
///管理分组表情的工具类  加载所有的表情数据
class HMZEmoticonManager: NSObject {
    
    //表情分组数组
    lazy var packages = [HMZEmoticonPackage]()
    static let shareEmotionManager = HMZEmoticonManager()
    
    func emoticonTextToImageText(text: String) -> NSAttributedString {
        
        //设计匹配规则
        let pattern = "\\[.*?\\]"
        //实例化正则表达式对象
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        //2.根据对应的表情文本 查询数组  -> 获取对应的表情模型
        //遍历数组 获取每一个表情字符串  倒序遍历数组
        
        
        //匹配到的结果
        let array = regex.matchesInString(text, options: [], range: NSRange(location: 0,length: text.characters.count))
        
        var index = array.count - 1
        let attrM = NSMutableAttributedString(string: text)
        while index >= 0 {
            //获取数组中的range对象
            let range = array[index].rangeAtIndex(0)
            //获取到每一个子串  通过子串 在数组进行对象的查询
            let subStr = (text as NSString).substringWithRange(range)
            if let em = getEmoticon(subStr) {
                //3.可以获取到对应图片  调用方法需要生写
                let imageText = HMZEmoticonAttachment().imageToAttrString(em, font: UIFont.systemFontOfSize(18))
                //4.替换表情文字 --> 包含了附件的属性 文本
                attrM.replaceCharactersInRange(range, withAttributedString: imageText)
            }
            index--
        }
        
        return attrM
    }
    
    
    func getEmoticon(string: String) ->HMZEmoticon? {
        for p in HMZEmoticonManager.shareEmotionManager.packages {
            //数组过滤器
            let emoticons = p.emoticons.filter({ (em) -> Bool in
                return em.chs == string
            })
            if let emoticon = emoticons.last {
                return emoticon
            }
        }
        return nil
    }
    
    
    //重写init方法
    override init() {
        super.init()
        loadPackages()
    }
    
    private func loadPackages() {
        let path = NSBundle.mainBundle().pathForResource("emoticons", ofType: "plist", inDirectory: "Emoticon.bundle")
        
        guard let filePath = path else {
            print("文件路径错误")
            return
        }
        let dict = NSDictionary(contentsOfFile: filePath)!
        let array = dict["packages"] as! [[String: AnyObject]]
        for item in array {
            let id = item["id"] as! String
            loadGroupPackages(id)
        }
    }
    
    private func loadGroupPackages(id: String) {
        let path = NSBundle.mainBundle().pathForResource("Info", ofType: "plist", inDirectory: "Emoticon.bundle/\(id)")
        
        guard let filePath = path else {
            print("文件路径错误")
            return
        }
        let dict = NSDictionary(contentsOfFile: filePath)!
        let group_name_cn = dict["group_name_cn"] as! String
        let array = dict["emoticons"] as! [[String: String]]
        let p = HMZEmoticonPackage(id: id, group_name_cn: group_name_cn, array: array)
        packages.append(p)
    }
}
