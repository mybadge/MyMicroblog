//
//  HMZStatusCell.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/15.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SnapKit

let StatusCellMargin: CGFloat = 12
let StatusCellImageWidth: CGFloat = 35
class HMZStatusCell: UITableViewCell {

    // 底部约束属性
    var topConstraints: Constraint?
    
    var status: HMZStatus? {
        didSet {
            statusOriginalView.status = status
            toolBar.status = status
            
            //移除工具条的顶部约束
            topConstraints?.uninstall()
            //设置转发微博的数据模型
            if status?.retweeted_status != nil {
                //就是转发微博
                statusRetweetedView.retweetedStatus = status?.retweeted_status
                //显示转发微博
                statusRetweetedView.hidden = false
                //更新约束
                toolBar.snp_updateConstraints(closure: { (make) -> Void in
                    self.topConstraints = make.top.equalTo(statusRetweetedView.snp_bottom).constraint
                })
            } else {
                //隐藏转发微博视图
                statusRetweetedView.hidden = true
                toolBar.snp_updateConstraints(closure: { (make) -> Void in
                    self.topConstraints = make.top.equalTo(statusOriginalView.snp_bottom).constraint
                })
            }

        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(toolBar)
        contentView.addSubview(statusOriginalView)
        contentView.addSubview(statusRetweetedView)
        //statusOriginalView.backgroundColor = UIColor.redColor()//为什么不显示颜色
        //toolBar.backgroundColor = HMZRandomColor()
        
        //添加约束
        statusOriginalView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(contentView)
        }
        
        statusRetweetedView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(contentView)
            make.top.equalTo(statusOriginalView.snp_bottom)
        }
        

        //底部视图的约束
        toolBar.snp_makeConstraints { (make) -> Void in
            self.topConstraints = make.top.equalTo(statusRetweetedView.snp_bottom).constraint
            make.left.right.equalTo(contentView)
            make.height.equalTo(40)
        }
        
        //需要给contentView添加约束
        contentView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
            //底部的约束非常关键
            make.bottom.equalTo(toolBar.snp_bottom)
        }
        //底部视图的约束
//        bottomView.snp_makeConstraints { (make) -> Void in
//            self.topConstraints = make.top.equalTo(retweetedView.snp_bottom).constraint
//            make.left.right.equalTo(contentView)
//            make.height.equalTo(40)
//        }
        
        //需要给contentView添加约束
//        contentView.snp_makeConstraints { (make) -> Void in
//            make.top.left.right.equalTo(self)
//            //底部的约束非常关键
//            make.bottom.equalTo(bottomView.snp_bottom)
//        }

        
//        toolBar.snp_makeConstraints { (make) -> Void in
//            make.bottom.equalTo(statusOriginalView.snp_top)
//            make.left.right.equalTo(contentView)
//            make.height.equalTo(40)
//            
//        }
//        
//        contentView.snp_makeConstraints { (make) -> Void in
//            make.left.top.right.equalTo(self)
//            make.bottom.equalTo(toolBar.snp_bottom)
//        }
//        toolBar.bringSubviewToFront(contentView)
    }
    
    
    //MARK: 懒加载姿势图
    private lazy var statusOriginalView: HMZStatusOriginalView = HMZStatusOriginalView()
    private lazy var statusRetweetedView: HMZStatusRetweetedView = HMZStatusRetweetedView()
    
    private lazy var toolBar: HMZStatusToolBar = HMZStatusToolBar()
    
}
