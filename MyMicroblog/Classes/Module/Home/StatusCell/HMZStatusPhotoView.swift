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
            
        }
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = photoCellMargin
        layout.minimumInteritemSpacing = photoCellMargin
        
        super.init(frame: frame, collectionViewLayout: layout)
        dataSource = self
        backgroundColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
    }
    
    var testLabel: UILabel = UILabel(title: "test")
}

//MARK: 数据源
extension HMZStatusPhotoView:UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(photoCellId, forIndexPath: indexPath)
        
        return cell
    }
}
