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
import FFLabel

/// 原创微博的自定义View
class HMZStatusOriginalView: UIView {
    //let margin = 10
    
    /// 底部约束属性 ,这个底部约束很总要,若不指定底部约束,cell就不知道有多高,就不会自动算出cell的高度,会是默认的44.
    var bottomConstraints: Constraint?
    
    var status: HMZStatus? {
        didSet {
            nameLabel.text = status?.user?.name
            iconView.sd_setImageWithURL(status?.user?.headImageURL,placeholderImage: UIImage(named: "avatar_default_big"))
            verified_type_image.image = status?.user?.verified_type_image
            
            //TODO: 后期完善
            timeLabel.text = status?.created_atStr
            sourceLabel.text = status?.source?.linkText().text
            contentLabel.text = status?.text
            
            
            // 使用约束属性  记录可能产生复用的约束  将可能复用的约束 解除掉
            bottomConstraints?.uninstall()
            
            //设置配图视图的图片数组
            //智能提示不好使
            if let urls = status?.imageURLs where urls.count != 0 {
                //有配图视图
                //设置数据源
                photoView.imageURLs = urls
                self.snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomConstraints = make.bottom.equalTo(photoView.snp_bottom).offset(StatusCellMargin).constraint
                })
                photoView.hidden = false
            } else {
                //无配图试图
                self.snp_updateConstraints(closure: { (make) -> Void in
                    //记录底部约束
                    //1.对底部添加约束  2.转换成约束对象 并且使用属性记录
                    self.bottomConstraints = make.bottom.equalTo(contentLabel.snp_bottom).offset(StatusCellMargin).constraint
                })
                photoView.hidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        //backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置ui
    private func setupUI() {
        
        sepView.backgroundColor = UIColor.lightGrayColor()
        addSubview(sepView)
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(vipView)
        addSubview(verified_type_image)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        
        addSubview(contentLabel)
        //指定代理
        contentLabel.labelDelegate = self
        
        addSubview(photoView)
        
        //设置布局
        
        sepView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
            make.height.equalTo(StatusCellMargin)
        }
        
        iconView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(sepView.snp_bottom).offset(StatusCellMargin)
            make.left.equalTo(self.snp_left).offset(StatusCellMargin)//这里需要注意
            make.width.height.equalTo(StatusCellImageWidth)
        }
        
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconView.snp_right).offset(StatusCellMargin)
            make.top.equalTo(iconView.snp_top)
        }
        
        vipView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(nameLabel.snp_right).offset(StatusCellMargin)
            make.top.equalTo(nameLabel.snp_top)
        }
        
        verified_type_image.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_right)
            make.centerY.equalTo(iconView.snp_bottom)
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
        
        
        //底部约束 由于需要根据具体的数据来进行更改 在setupUI中 无法拿到具体数据 无法在这个进行更改
        self.snp_makeConstraints { (make) -> Void in
            self.bottomConstraints = make.bottom.equalTo(photoView.snp_bottom).offset(StatusCellMargin).constraint
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
    private lazy var contentLabel: FFLabel = FFLabel(title: "hehe", color: UIColor.blackColor(), fontSize: 14, margin: StatusCellMargin)
    /// 相册
    private lazy var photoView: HMZStatusPhotoView = HMZStatusPhotoView()
}

extension HMZStatusOriginalView:FFLabelDelegate {
    func labelDidSelectedLinkText(label: FFLabel, text: String) {
        if text.hasPrefix("http") {
            let tempVc = HMZTempWebViewController()
            tempVc.urlString = text
            self.getNavController()?.pushViewController(tempVc, animated: true)
        }
    }
}
