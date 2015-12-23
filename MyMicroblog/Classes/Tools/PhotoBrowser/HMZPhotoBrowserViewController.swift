//
//  HMZPhotoBrowserViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/23.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SVProgressHUD

private let PhotoBrowserCellId = "PhotoBrowserCellId"

/// 照片浏览器
class HMZPhotoBrowserViewController: UIViewController {
    
    /// 集合视图,用于呈现图片,可供外界调用的属性
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRectZero, collectionViewLayout: PhotoBrowserViewLayout())
        //为item 注册类
        cv.registerClass(HMZPhotoBrowserCell.self, forCellWithReuseIdentifier: PhotoBrowserCellId)
        //指定代理
        cv.dataSource = self
        return cv
    }()

    
    private var urls: [NSURL]
    private var currentIndexPath: NSIndexPath
    init(urls: [NSURL], indexPath: NSIndexPath) {
        self.urls = urls
        self.currentIndexPath = indexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        var rect = UIScreen.mainScreen().bounds
        rect.size.width += 20
        view = UIView(frame: rect)
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //滚动到指定位置
        collectionView.scrollToItemAtIndexPath(currentIndexPath, atScrollPosition: .CenteredHorizontally, animated: false)
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
        view.addSubview(titleLabel)
        titleLabel.text = "\(currentIndexPath.item + 1) / \(urls.count)"
        collectionView.frame = view.bounds
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp_top).offset(20)
            make.centerX.equalTo(view.snp_centerX)
        }
        closeBtn.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(-8)
            make.left.equalTo(view.snp_left).offset(8)
            make.size.equalTo(CGSize(width: 100, height: 36))
        }
        saveBtn.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(-8)
            make.right.equalTo(view.snp_right).offset(-28)
            make.size.equalTo(CGSize(width: 100, height: 36))
        }
        closeBtn.addTarget(self, action: "close", forControlEvents: .TouchUpInside)
        saveBtn.addTarget(self, action: "save", forControlEvents: .TouchUpInside)
    }
    
    //MARK: - 懒加载控件
    /// 关闭按钮
    private lazy var closeBtn: UIButton = UIButton(title: "关闭", backgroundImage: nil, color: UIColor.whiteColor())
    /// 保存按钮
    private lazy var saveBtn: UIButton = UIButton(title: "保存", backgroundImage: nil, color: UIColor.whiteColor())
    private lazy var titleLabel: UILabel = UILabel(title: "0/0", color: UIColor.whiteColor(), fontSize: 17)
    
    //MARK: -自定义了流水布局私有类 为什么要这样写呢？？？？
    /// 自定义了流水布局私有内部类
    private class PhotoBrowserViewLayout: UICollectionViewFlowLayout {
        private override func prepareLayout() {
            super.prepareLayout()
            itemSize = collectionView!.bounds.size
            minimumLineSpacing = 0
            minimumInteritemSpacing = 0
            scrollDirection = .Horizontal
            collectionView?.pagingEnabled = true
            collectionView?.bounces = false
            collectionView?.showsHorizontalScrollIndicator = false
        }
    }
}

// MARK: - 集合视图数据源方法
extension HMZPhotoBrowserViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserCellId, forIndexPath: indexPath) as! HMZPhotoBrowserCell
        titleLabel.text = "\(indexPath.item + 1) / \(urls.count)"
        cell.imageURL = urls[indexPath.item]
        cell.photoDelegate = self
        return cell
    }
}

// MARK: - cell视图代理方法
extension HMZPhotoBrowserViewController: HMZPhotoBrowserCellDelegate {
    func photoBrowserCellShouldDismiss() {
        close()
    }
    
    func photoBrowserCellDidZoom(scale: CGFloat) {
        let isHidden = scale < 1
        hideControls(isHidden)
        
        if isHidden {
            view.alpha = scale
            view.transform = CGAffineTransformMakeScale(scale, scale)
        } else {
            view.alpha = 1.0
            view.transform = CGAffineTransformIdentity
        }
    }
    
    private func hideControls(isHidden: Bool) {
        closeBtn.hidden = isHidden
        saveBtn.hidden = isHidden
        collectionView.backgroundColor = isHidden ? UIColor.clearColor() : UIColor.blackColor()
    }
    
}

// MARK: - 监听方法
extension HMZPhotoBrowserViewController {
    @objc private func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func save() {
        let cell = collectionView.visibleCells()[0] as! HMZPhotoBrowserCell
        guard let image = cell.imageView.image else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    @objc private func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject?) {
        let message = (error == nil) ? "保存成功" : "保存失败"
        SVProgressHUD.showInfoWithStatus(message)
    }
}
