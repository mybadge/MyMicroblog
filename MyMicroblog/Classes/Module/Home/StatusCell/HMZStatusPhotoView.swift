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

    var imageURLs:[NSURL]?

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = photoCellMargin
        layout.minimumInteritemSpacing = photoCellMargin
        
        super.init(frame: frame, collectionViewLayout: layout)
     
        backgroundColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
    }
    
    

}
