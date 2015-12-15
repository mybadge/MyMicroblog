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

    var status: HMZStatus? {
        didSet {
//            textLabel?.text = status?.text
//            textLabel?.numberOfLines = 0
            statusOriginalView.status = status
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        selectionStyle = .None
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(statusOriginalView)
        contentView.addSubview(bottomView)
        //添加约束
        statusOriginalView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(contentView)
        }
        
        bottomView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self)
//            make.height.
        }
        contentView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(bottomView.snp_bottom)
        }
    }
    
    
    //MARK: 懒加载姿势图
    private lazy var statusOriginalView: HMZStatusOriginalView = HMZStatusOriginalView()
    private lazy var bottomView: UIView = UIView()
    
}
