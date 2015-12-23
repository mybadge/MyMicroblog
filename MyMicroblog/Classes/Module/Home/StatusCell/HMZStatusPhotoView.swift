//
//  HMZStatusPhotoView.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/16.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

private let photoCellId = "photoCellId"
private let photoCellMargin: CGFloat = 5
class HMZStatusPhotoView: UICollectionView {
    
    var imageURLs:[NSURL]? {
        didSet {
            testLabel.text = "\(imageURLs?.count ?? 0)"
            let photoSize = getPhotoViewSize()
            //print("\(testLabel.text)" + "\(photoSize)")
            self.snp_updateConstraints { (make) -> Void in
                make.size.equalTo(photoSize)
            }
            reloadData()
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = photoCellMargin
        layout.minimumInteritemSpacing = photoCellMargin
        
        super.init(frame: frame, collectionViewLayout: layout)
        dataSource = self
        delegate = self
        backgroundColor = UIColor(white: 0.9, alpha: 1)
        //注册Cell类型
        registerClass(HMZStatusPhotoCell.self, forCellWithReuseIdentifier: photoCellId)
        
        //setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(testLabel)
        testLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.center)
        }
    }
    
    private func getPhotoViewSize() ->CGSize {
        let imageCount = imageURLs?.count ?? 0
        let maxWidth = screenW - 2 * StatusCellMargin
        let itemWidth = (maxWidth - 2 * photoCellMargin) / 3.001
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        switch(imageCount){//只有这几种情况
        case 0: return CGSizeZero
        case 1:
            var imageSize = CGSize(width: 180, height: 120)
            let key = imageURLs?.first?.absoluteString ?? ""
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
            if image != nil {
                imageSize = image.size
            }
            imageSize.width = imageSize.width > maxWidth ? maxWidth :imageSize.width
            imageSize.height = imageSize.height > 250 ? 250.0 : imageSize.height
            layout.itemSize = imageSize
            return imageSize
        case 4:
            let viewWH = itemWidth * 2.01 + photoCellMargin
            return CGSize(width: viewWH, height: viewWH)
            
        default://其他几种图片
            let row = CGFloat((imageCount - 1) / 3 + 1)
            let viewH = itemWidth * row + photoCellMargin * (row - 1)
            
            return CGSize(width: maxWidth, height: viewH)
        }
    }
    
    private lazy var testLabel: UILabel = UILabel(title: "test",color: UIColor.redColor(), fontSize: 20)
}

//MARK: 数据源
extension HMZStatusPhotoView:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(photoCellId, forIndexPath: indexPath) as! HMZStatusPhotoCell
        cell.imageURL = imageURLs![indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 测试动画转场协议函数
        //        photoBrowserPresentFromRect(indexPath)
        //        photoBrowserPresentToRect(indexPath)
        
        // 明确问题：传递什么数据？当前 URL 的数组／当前用户选中的索引
        // 如何传递：通知
        // 通知：名字(通知中心监听)/object：发送通知的同时传递对象(单值)/ userInfo 传递多值的时候，使用的数据字典 -> Key

        let userInfo = [HMZStatusSelectedPhotoIndexPathKey: indexPath, HMZStatusSelectedPhotoURLsKey: imageURLs!]
        NSNotificationCenter.defaultCenter().postNotificationName(HMZStatusSelectedPhotoNotification, object: self, userInfo: userInfo)
    }
}

//MARK: HMZStatusPhotoCell 自定义
class HMZStatusPhotoCell: UICollectionViewCell {
    var imageURL: NSURL? {
        didSet {
            //TODO: 改成正在加载中,
            pictureView.sd_setImageWithURL(imageURL, placeholderImage: UIImage(named: "avatar_default_big"), options: .DelayPlaceholder)
        }
    }
    private lazy var pictureView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(pictureView)
        pictureView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp_edges)
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
