//
//  HMZMainTabBar.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/12.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

class HMZMainTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(composeBtn)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.bounds.width / 5
        let h = self.bounds.height
        let rect = CGRectMake(0, 0, w, h)
        var index: CGFloat = 0
        for subView in subviews {
            if subView.isKindOfClass(NSClassFromString("UITabBarButton")!){
                subView.frame = CGRectOffset(rect, w * index, 0)
                index += (index == 1 ? 2 : 1)
            }
        }
        composeBtn.frame = CGRectOffset(rect, w * 2, 0)
    }
    
    lazy var composeBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        btn.sizeToFit()
        return btn
    }()
}
