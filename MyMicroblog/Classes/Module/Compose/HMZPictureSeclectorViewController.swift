//
//  HMZPictureSeclectorViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/19.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PictureCellId"
private let cellMargin:CGFloat = 10
private let rowCount:CGFloat = 4
private let maxImageCount = 9

class HMZPictureSeclectorViewController: UICollectionViewController {
    /// 图片列表
    lazy var imageList: [UIImage] = {
        var list = [UIImage]()
        //list.append(UIImage(named: "compose_camerabutton_background")!)
        return list
    }()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        let itemWH = (screenW - (rowCount + 1)*cellMargin) / rowCount
        layout.itemSize = CGSizeMake(itemWH, itemWH)
        layout.sectionInset = UIEdgeInsetsMake(cellMargin, 0, cellMargin, cellMargin)
        layout.minimumInteritemSpacing = cellMargin
        layout.minimumLineSpacing = cellMargin
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 注册cell类型
        self.collectionView!.registerClass(HMZPictureSelectorCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    
    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let delta = imageList.count == maxImageCount ? 0 : 1
        return imageList.count + delta
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! HMZPictureSelectorCell
        cell.delegate = self
        if imageList.count == indexPath.item {
            cell.image = nil
        } else {
            cell.image = imageList[indexPath.item]
        }
        return cell
    }
}

// MARK: - 调用系统获取相簿 代理方法
extension HMZPictureSeclectorViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    ///选择相簿图片
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageList.append(image)
        collectionView?.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension HMZPictureSeclectorViewController: HMZPictureSelectorCellDelegate {
    func userWillChosePicture(cell: HMZPictureSelectorCell) {
                
        openImagePickerController(.PhotoLibrary)
    }
    func userWillDeletePicture(cell: HMZPictureSelectorCell) {
        //这样写有问题，每次点击删除都是最后一个，是不对的
        //imageList.removeLast()
        //这样才对
        let indexPath = (collectionView?.indexPathForCell(cell))!
        imageList.removeAtIndex(indexPath.item)
        collectionView?.reloadData()
    }
    
    
    func openImagePickerController(type: UIImagePickerControllerSourceType) {
        //如果选择的类型用户不让用，就是没有授权，就返回
        if !UIImagePickerController.isSourceTypeAvailable(type) {
            return
        }
        let pickerVc = UIImagePickerController()
        pickerVc.sourceType = type
        pickerVc.delegate = self
        presentViewController(pickerVc, animated: true, completion: nil)
    }
}


///  定义 选择图片和删除已选择图片的 协议方法

@objc protocol HMZPictureSelectorCellDelegate: NSObjectProtocol {
    /// 将要选择图片
    optional func userWillChosePicture(cell: HMZPictureSelectorCell)
    /// 将要删除图片
    optional func userWillDeletePicture(cell: HMZPictureSelectorCell)
//    /// 将要选择相机
//    optional func userWillChoseCamera(cell: HMZPictureSelectorCell)
}

class HMZPictureSelectorCell: UICollectionViewCell {
    /// 代理: 声明一个弱引用的代理
    var delegate: HMZPictureSelectorCellDelegate?
    
    /// 成功选择的图片
    var image: UIImage? {
        didSet{
            deleteBtn.hidden = image == nil

            if image == nil {//如果为空显示添加按钮
                addBtn.setImage(UIImage(named: "compose_pic_add"), forState: .Normal)
                addBtn.userInteractionEnabled = true
                return
            }
            //不为空显示已经选择的图片
            addBtn.setImage(image, forState: .Normal)
            addBtn.userInteractionEnabled = false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(addBtn)
        //addSubview(cameraBtn)
        //设置布局
        addBtn.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp_edges)
        }
        //cameraBtn.snp_makeConstraints { (make) -> Void in
        //    make.edges.equalTo(contentView.snp_edges)
        //}
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func addBtnDidClick() {
       
    
        delegate?.userWillChosePicture?(self)
    }
    @objc private func deleteBtnDidClick() {
        delegate?.userWillDeletePicture?(self)
    }
//    @objc private func cameraBtnDidClick() {
//        delegate?.userWillChoseCamera?(self)
//    }
    
    ///添加图片按钮
    private lazy var addBtn: UIButton = {
        let btn = UIButton(imageName: "compose_pic_add", backgroundImage: nil)
        btn.addTarget(self, action: "addBtnDidClick", forControlEvents: .TouchUpInside)
        btn.imageView?.contentMode = .ScaleAspectFill
        return btn
    }()
    
    /// 删除已选泽图片按钮
    private lazy var deleteBtn: UIButton = {
        let btn = UIButton(imageName: "compose_photo_close", backgroundImage: nil)
        self.addSubview(btn)
        btn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self.contentView.snp_right)
            make.top.equalTo(self.contentView.snp_top)
        }
        btn.addTarget(self, action: "deleteBtnDidClick", forControlEvents: .TouchUpInside)
        return btn
    }()
    
//    private lazy var cameraBtn: UIButton = {
//        let btn = UIButton(imageName: "compose_camerabutton_background", backgroundImage: nil)
//        btn.addTarget(self, action: "cameraBtnDidClick", forControlEvents: .TouchUpInside)
//        btn.imageView?.contentMode = .ScaleAspectFill
//        return btn
//    }()
    
    
}
