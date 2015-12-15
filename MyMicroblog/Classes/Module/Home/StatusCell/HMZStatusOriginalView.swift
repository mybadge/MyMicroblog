//
//  HMZStatusOriginalView.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/15.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

/// 原创微博的自定义View
class HMZStatusOriginalView: UIView {
    //let margin = 10
    
    var status: HMZStatus? {
        didSet {
            nameLabel.text = status?.user?.name
            iconView.sd_setImageWithURL(status?.user?.headImageURL,placeholderImage: UIImage(named: "avatar_default_big"))
            verified_type_image.image = status?.user?.verified_type_image
            
            //TODO: 后期完善
            timeLabel.text = status?.created_at
            sourceLabel.text = status?.source
            contentLabel.text = status?.text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        sepView.backgroundColor = UIColor.grayColor()
        addSubview(sepView)
        addSubview(iconView)
        addSubview(verified_type_image)
        addSubview(nameLabel)
        addSubview(vipView)
        addSubview(sourceLabel)
        addSubview(timeLabel)
        addSubview(contentLabel)
        addSubview(photoView)
        
        //设置约束
        sepView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(self)
            make.height.equalTo(self).offset(StatusCellMargin)
        }
        iconView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(sepView.snp_bottom).offset(StatusCellMargin)
            make.left.equalTo(self.snp_left).offset(StatusCellMargin)
            make.width.height.equalTo(StatusCellImageWidth)
        }
        verified_type_image.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_right)
            make.centerY.equalTo(iconView.snp_bottom)
        }
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconView.snp_right).offset(StatusCellMargin)
            make.top.equalTo(iconView.snp_top)
        }
        
        vipView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(nameLabel.snp_right).offset(StatusCellMargin)
            make.top.equalTo(nameLabel.snp_top)
        }
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconView.snp_right).offset(StatusCellMargin)
            make.bottom.equalTo(iconView.snp_bottom)
        }
        sourceLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(timeLabel.snp_right).offset(StatusCellMargin)
            make.bottom.equalTo(timeLabel.snp_bottom)
        }
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left).offset(StatusCellMargin)
            make.top.equalTo(iconView.snp_bottom).offset(StatusCellMargin)
        }
        photoView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp_bottom).offset(StatusCellMargin)
            make.left.equalTo(contentLabel.snp_left)
        }
        
    }
    
    
    //MARK: 懒加载所有的子视图
    
    /// Cell之间的分割线
    private lazy var sepView: UIView = UIView()
    /// 头像
    private lazy var iconView: UIImageView = UIImageView()
    /// 加V 认证
    private lazy var verified_type_image: UIImageView = UIImageView(image: UIImage(named: "avatar_vip"))
    /// vip标识
    private lazy var vipView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    /// 名称
    private lazy var nameLabel: UILabel = UILabel(title: "大家好", color: UIColor.darkGrayColor(), fontSize: 14)
    /// 时间
    private lazy var timeLabel: UILabel = UILabel(title: "11.11", color: HMZThemeColor, fontSize: 12)
    /// 来源
    private lazy var sourceLabel: UILabel = UILabel(title: "火星", color: UIColor.grayColor(), fontSize: 12)
    /// 正文内容
    private lazy var contentLabel: UILabel = UILabel(title: "hehe", color: UIColor.blackColor(), fontSize: 14, margin: StatusCellMargin)
    /// 相册
    private lazy var photoView: UIView = {
        let v = UIView()
        v.addSubview(UILabel(title: "如知后事如何,请看下集", color: UIColor.purpleColor(), fontSize: 20, margin: 12))
        return v
    }()
    
}
