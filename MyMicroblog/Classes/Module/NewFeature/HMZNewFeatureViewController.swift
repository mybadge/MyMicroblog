//
//  HMZNewFeatureViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/14.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "CellId"
private let maxItemCount = 4

class HMZNewFeatureViewController: UICollectionViewController {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UIScreen.mainScreen().bounds.size
        layout.scrollDirection = .Horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        super.init(collectionViewLayout: layout)
        
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        //弹簧效果
        collectionView?.bounces = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purpleColor()
        // Register cell classes
        self.collectionView!.registerClass(HMZNewFeatureViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: 数据源代理
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return maxItemCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! HMZNewFeatureViewCell
        cell.index = indexPath.item
        return cell
    }
    
    // MARK: 代理方法
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.visibleCells().last as! HMZNewFeatureViewCell
        let indexPath = collectionView.indexPathForCell(cell)
        if indexPath!.item == maxItemCount - 1 {
            cell.startAnimation()
        }
    }
    
    
}



class HMZNewFeatureViewCell: UICollectionViewCell {
    //定义属性
    var index: Int = 0 {
        didSet {
            iconView.image = UIImage(named: "new_feature_\(index + 1)")
            shareBtn.hidden = true
            startBtn.hidden = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///  初始化界
    private func setupUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(shareBtn)
        contentView.addSubview(startBtn)
        
        //设置布局
        
        iconView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp_edges)
        }
        
        startBtn.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(135)
            make.centerX.equalTo(contentView.snp_centerX)
            make.bottom.equalTo(contentView.snp_bottom).offset(-180)
            
        }
        
        
        shareBtn.snp_makeConstraints { (make) -> Void in
            make.trailing.equalTo(startBtn.snp_trailing)
            make.bottom.equalTo(startBtn.snp_top).offset(-20)
            make.width.equalTo(135)
        }
        
    }
    
    func startAnimation() {
        shareBtn.hidden = false
        startBtn.hidden = false
        //shareBtn.backgroundColor = UIColor.redColor()
        //startBtn.backgroundColor = UIColor.yellowColor()
        //添加动画
        shareBtn.transform = CGAffineTransformMakeScale(0, 0)
        startBtn.transform = CGAffineTransformMakeScale(0, 0)
        
        /**
        iOS 7.0 推出的动画效果   弹簧系数 * 10  ~= 加速度
        - duartion                          持续事件
        - parameter delay:                  延迟时间
        - parameter usingSpringWithDamping: 弹簧效果 0.1 ~ 1之间  越小越弹
        - parameter initialSpringVelocity:  加速度
        - parameter options:                动画可选项
        - parameter animations:             完成动画闭包
        - parameter completion:             动画结束后的闭包
        */
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: { () -> Void in
            self.shareBtn.transform = CGAffineTransformIdentity
            self.startBtn.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
                printLog("OK")
        }
    }
    
    @objc private func startBtnDidClick() {
        NSNotificationCenter.defaultCenter().postNotificationName(HMZSwitchRootVCNotificationKey, object: "Welcome")
    }
    
    @objc private func shareBtnDidClick(sender: UIButton) {
        sender.selected = !sender.selected
    }
    
    
    /// 新特性图片
    private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "new_feature_1"))
    
    /// 开始按钮
    private lazy var startBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("开始体验", forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: .Highlighted)
        btn.sizeToFit()
        btn.addTarget(self, action: "startBtnDidClick", forControlEvents: .TouchUpInside)
        return btn
    }()
    
    /// 分享按钮
    private lazy var shareBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("分享给大家", forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.setImage(UIImage(named: "new_feature_share_false"), forState: .Normal)
        btn.setImage(UIImage(named: "new_feature_share_true"), forState: .Selected)
        //自切属性
        //btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        btn.sizeToFit()
        btn.contentHorizontalAlignment = .Left
        btn.addTarget(self, action: "shareBtnDidClick:", forControlEvents: .TouchUpInside)
        return btn
    }()
    
    
    
}
