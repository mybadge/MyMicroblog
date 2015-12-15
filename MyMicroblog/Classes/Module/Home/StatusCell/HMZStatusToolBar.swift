//
//  HMZStatusToolBar.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/15.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SnapKit

class HMZStatusToolBar: UIView {
    
    var status: HMZStatus? {
        didSet {
            let repost = "\(status?.reposts_count ?? 0)" == "0" ? "转发" : "\(status?.reposts_count ?? 0)"
            let comments = "\(status?.comments_count ?? 0)" == "0" ? "评论" : "\(status?.comments_count ?? 0)"
            let attitudes = "\(status?.attitudes_count ?? 0)" == "0" ? "赞" : "\(status?.attitudes_count ?? 0)"
            
            repostBtn.setTitle(repost, forState: .Normal)
            commentBtn.setTitle(comments, forState: .Normal)
            attitudeBtn.setTitle(attitudes, forState: .Normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(repostBtn)
        addSubview(commentBtn)
        addSubview(attitudeBtn)
        
        //设置约束--- 三等分视图
        repostBtn.snp_makeConstraints { (make) -> Void in
            make.left.top.bottom.equalTo(self)
        }
        commentBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(repostBtn.snp_right)
            make.top.bottom.equalTo(self)
            make.width.equalTo(repostBtn.snp_width)
        }
        attitudeBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(commentBtn.snp_right)
            make.right.equalTo(self.snp_right)
            make.width.equalTo(commentBtn.snp_width)
            make.top.bottom.equalTo(self)
        }
        
        let sepView1 = sepView()
        let sepView2 = sepView()
        let w = 0.5
        let scale = 0.4
        
        sepView1.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(repostBtn.snp_right)
            make.centerY.equalTo(self.snp_centerY)
            make.width.equalTo(w)
            make.height.equalTo(self.snp_height).multipliedBy(scale)
        }
        sepView2.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(commentBtn.snp_right)
            make.centerY.equalTo(self.snp_centerY)
            make.width.equalTo(w)
            make.height.equalTo(self.snp_height).multipliedBy(scale)
        }
    }
    
    
    private func sepView() ->UIView {
        let v = UIView()
        v.backgroundColor = UIColor.darkGrayColor()
        addSubview(v)
        return v
    }
    
    //MARK: 懒加载
    /// 转发按钮
    private lazy var repostBtn: UIButton = UIButton(title: "转发", backgroundImage: nil, color: UIColor.darkTextColor(), fontSize: 13, isNeedHighighted: false, imageName: "timeline_icon_retweet")
    /// 评论按钮
    private lazy var commentBtn: UIButton = UIButton(title: "评论", backgroundImage: nil, color: UIColor.darkTextColor(), fontSize: 13, isNeedHighighted: false, imageName: "timeline_icon_comment")
    /// 点赞按钮 attitude :态度
    private lazy var attitudeBtn: UIButton = UIButton(title: "赞", backgroundImage: nil, color: UIColor.darkTextColor(), fontSize: 13, isNeedHighighted: false, imageName: "timeline_icon_unlike")
}
