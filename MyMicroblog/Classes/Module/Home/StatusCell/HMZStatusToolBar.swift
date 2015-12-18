//
//  HMZStatusToolBar.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/15.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

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
        backgroundColor = UIColor(white: 0.90, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func commentBtnDidClick() {
        //print(__FUNCTION__)
        let commentVc = HMZStatusCommentController()
        commentVc.statusId = status?.id ?? 0
        commentVc.title = "微博正文"
        getNavController()?.pushViewController(commentVc, animated: true)
    }
    @objc private func repostBtnDidClick() {
        guard let statusId = status?.id  else {
            return
        }
        HMZStatusViewModel.repostStatus(statusId, finish: { (result) -> () in
            if result {
                SVProgressHUD.showSuccessWithStatus("转发成功")
            } else {
                SVProgressHUD.showErrorWithStatus("转发失败")
            }
        })
        
    }
    
    private func setupUI() {
        addSubview(repostBtn)
        addSubview(commentBtn)
        addSubview(attitudeBtn)
        
        repostBtn.addTarget(self, action: "repostBtnDidClick", forControlEvents: .TouchUpInside)
        commentBtn.addTarget(self, action: "commentBtnDidClick", forControlEvents: .TouchUpInside)
        
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
        let sepViewTop = sepView()
        let sepViewBottom = sepView()
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
        sepViewTop.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(self)
            make.width.equalTo(screenW)
            make.height.equalTo(0.5)
        }
        sepViewBottom.snp_makeConstraints { (make) -> Void in
            make.left.bottom.right.equalTo(self)
            make.width.equalTo(screenW)
            make.height.equalTo(0.5)
        }
        
    }
    
    
    private func sepView() ->UIView {
        let v = UIView()
        v.backgroundColor = UIColor(red: 228, green: 224, blue: 228, alpha: 1)
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
