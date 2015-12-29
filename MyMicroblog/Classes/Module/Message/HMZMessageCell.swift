//
//  HMZMessageCell.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/29.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SnapKit

class HMZMessageCell:UITableViewCell {
    private let imageWidth:CGFloat = 60
    private let margin:CGFloat = 10
    
    var bottomConstraints: Constraint?
    
    var user: HMZUser?{
        didSet{
            nameLabel.text = user?.name
            desLabel.text = user?.des
            timeLabel.text = user?.created_atStr
            iconView.sd_setImageWithURL(user?.avatar_largeURL)
            
            self.bottomConstraints?.uninstall()
            //计算文字的size,去跟头像最大Y值去比较,谁大用谁的约束.
            let descSize = ((user?.des ?? "") as NSString).boundingRectWithSize(CGSize(width: screenW - imageWidth - margin*3, height: CGFloat.max), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(12)], context: nil).size
            
            contentView.snp_updateConstraints { (make) -> Void in
                if (desLabel.frame.origin.y+descSize.height) > (imageWidth + margin) {
                    self.bottomConstraints = make.bottom.equalTo(desLabel.snp_bottom).offset(margin).constraint
                } else {
                    self.bottomConstraints = make.bottom.equalTo(iconView.snp_bottom).offset(margin).constraint
                }
            }
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .Gray
        
        
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        nameLabel.textAlignment = .Left
        contentView.addSubview(timeLabel)
        contentView.addSubview(desLabel)
        
        //desLabel.preferredMaxLayoutWidth = screenW - imageWidth - 3*margin
        desLabel.textAlignment = .Left
        
        
        //添加约束
        iconView.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(contentView).offset(margin)
            make.height.width.equalTo(imageWidth)
        }
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconView.snp_right).offset(margin)
            make.top.equalTo(iconView.snp_top)
        }
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(nameLabel.snp_right).offset(margin)
            make.right.equalTo(contentView.snp_right).offset(-margin)
            make.top.equalTo(contentView.snp_top).offset(margin)
        }
        desLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconView.snp_right).offset(margin)
            make.top.equalTo(nameLabel.snp_bottom).offset(margin)
            make.right.equalTo(contentView.snp_right).offset(-margin)
        }
        contentView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(self)
            self.bottomConstraints = make.bottom.equalTo(iconView.snp_bottom).offset(margin).constraint
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 头像
    private lazy var iconView: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 30
        v.layer.masksToBounds = true
        return v
    }()
    /// 名称
    private lazy var nameLabel: UILabel = UILabel(title: "大家好", color: UIColor.blackColor(), fontSize: 15)
    /// 创建时间
    private lazy var timeLabel: UILabel = UILabel(title: "11.11", color: UIColor.grayColor(), fontSize: 12)
    /// 描述
    private lazy var desLabel: UILabel = UILabel(title: "火星", color: UIColor.grayColor(), fontSize: 12)
    
}

