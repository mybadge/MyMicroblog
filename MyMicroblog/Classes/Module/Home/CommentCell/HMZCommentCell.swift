//
//  HMZCommentCell.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/18.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SnapKit

class HMZCommentCell: UITableViewCell {
    
    private let margin: CGFloat = 10
    private let imageWidth: CGFloat = 60
    
    //var bottomConstraints: Constraint?
    
    var comment: HMZStatusComment?{
        didSet{
            iconView.sd_setImageWithURL(comment?.user?.avatar_largeURL)
            nameLabel.text = comment?.user?.name
            timeLabel.text = comment?.created_atStr
            //desLabel.text = comment?.text
            desLabel.attributedText = HMZEmoticonManager.shareEmotionManager.emoticonTextToImageText(comment?.text ?? "")
            
//            bottomConstraints?.uninstall()
//            contentView.snp_updateConstraints { (make) -> Void in
//                make.bottom.equalTo(desLabel.snp_bottom)
//            }
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(desLabel)
        contentView.addSubview(attitudeBtn)
        desLabel.textAlignment = .Left
        //desLabel.preferredMaxLayoutWidth = screenW - imageWidth - 3*margin
        
        //添加约束
        iconView.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(contentView).offset(margin)
            make.height.width.equalTo(imageWidth)
        }
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconView.snp_right).offset(margin)
            make.top.equalTo(iconView.snp_top)
        }
        attitudeBtn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(contentView.snp_right).offset(-margin)
            make.top.equalTo(contentView.snp_top).offset(margin)
        }
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconView.snp_right).offset(margin)
            //为什么显示有问题??  reason：需要相对于self，不能相对于contentView
            //make.right.equalTo(contentView.snp_right).offset(margin)
            make.top.equalTo(nameLabel.snp_bottom).offset(margin)
        }
        desLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconView.snp_right).offset(margin)
            make.top.equalTo(timeLabel.snp_bottom).offset(margin)
            make.right.equalTo(contentView.snp_right).offset(-margin)
        }
        
        
        
        contentView.snp_makeConstraints { (make) -> Void in
            //make.height.equalTo(imageWidth + 2*margin)
            //self.bottomConstraints =
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(desLabel.snp_bottom).offset(margin)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 评论人头像
    private lazy var iconView: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 30
        v.layer.masksToBounds = true
        return v
    }()
    /// 评论人姓名
    private lazy var nameLabel: UILabel = UILabel(title: "大家好", color: UIColor.blackColor(), fontSize: 15)
    /// 评论时间
    private lazy var timeLabel: UILabel = UILabel(title: "11.11", color: UIColor.grayColor(), fontSize: 12)
    /// 评论内容
    private lazy var desLabel: UILabel = UILabel(title: "火星", color: UIColor.grayColor(), fontSize: 12)
    
    /// 点赞按钮 attitude :态度
    private lazy var attitudeBtn: UIButton = UIButton(title: "赞", backgroundImage: nil, color: UIColor.darkTextColor(), fontSize: 10, isNeedHighighted: false, imageName: "timeline_icon_unlike")
    
}