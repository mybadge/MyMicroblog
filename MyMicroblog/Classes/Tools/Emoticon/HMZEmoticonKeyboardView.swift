//
//  HMZEmoticonKeyboardView.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/18.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

private let emoticonCellId = "emoticonCellId"
private let toolBarHeight:CGFloat = 36

class HMZEmoticonKeyboardView: UIView {
    /// 表情分组数组
    private lazy var packages = HMZEmoticonManager.shareEmotionManager.packages
    /// 选中表情的一个闭包函数
    var selectEmoticon: (em: HMZEmoticon) ->()
    
    init(selectEmoticon:(em: HMZEmoticon) ->()) {
        self.selectEmoticon = selectEmoticon
        let frame = CGRect(x: 0, y: 0, width: screenW, height: 220)
        super.init(frame:frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(toolBar)
        addSubview(collectionView)
        
        toolBar.snp_makeConstraints { (make) -> Void in
            make.left.bottom.right.equalTo(self)
            make.height.equalTo(toolBarHeight)
        }
        collectionView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(toolBar.snp_top)
        }
        setupToolBar()
    }
    
    private func setupToolBar() {
        toolBar.tintColor = UIColor.lightGrayColor()
        var items = [UIBarButtonItem]()
        //设置数据源
        //通常一组功能相近按钮的响应事件的区分  一般使用 tag
        var index = 0
        for p in packages {
            let item = UIBarButtonItem(title: p.group_name_cn, style: .Plain, target: self, action: "itemSelected:")
            items.append(item)
            item.tag = index++
            //添加弹簧
            let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            items.append(space)
        }
        if items.count > 0 {
            items.removeLast()
        }
        
        toolBar.items = items
    }
    
    //MARK: 监听方法
    @objc private func itemSelected(sender: UIBarButtonItem) {
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: sender.tag), atScrollPosition: .CenteredHorizontally, animated: true)
    }
    
    //MARK: 懒加载所有的子控件
    private lazy var toolBar: UIToolbar = UIToolbar()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        let itemWH = screenW / 7
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        
        //计算组间距
        let margin = (self.bounds.height - 3*itemWH - toolBarHeight) / 4
        layout.sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
        let cv = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.whiteColor()
        cv.dataSource = self
        cv.delegate = self
        cv.pagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.registerClass(HMZEmoticonCell.self, forCellWithReuseIdentifier: emoticonCellId)
        
        return cv
    }()
}

// MARK: - collection的数据源和代理
extension HMZEmoticonKeyboardView:UICollectionViewDataSource,UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return packages.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packages[section].emoticons.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(emoticonCellId, forIndexPath: indexPath) as! HMZEmoticonCell
        cell.emoticon = packages[indexPath.section].emoticons[indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let em = packages[indexPath.section].emoticons[indexPath.item]
        //执行闭包....好高深啊??????
        selectEmoticon(em: em)
    }
}

/// 表情cell
class HMZEmoticonCell: UICollectionViewCell {
    var emoticon: HMZEmoticon? {
        didSet {
            emoticonBtn.setImage(emoticon?.image, forState: .Normal)
            emoticonBtn.setTitle(emoticon?.emojiStr, forState: .Normal)
            if let e = emoticon where e.isDelete {
                emoticonBtn.setImage(UIImage(named: "compose_emotion_delete"), forState: .Normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 懒加载
    private lazy var emoticonBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.whiteColor()
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        self.addSubview(btn)
        //????
        btn.frame = CGRectInset(self.bounds,4,4)
        btn.titleLabel?.font = UIFont.systemFontOfSize(32)
        //???? why?
        btn.userInteractionEnabled = false
        return btn
    }()
}
