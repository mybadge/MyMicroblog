//
//  HMZComposeViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/17.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
//import SnapKit
import SVProgressHUD

class HMZComposeViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //当图片选择器中选择了图片时，就不弹出键盘
        if selectorPictureVc.imageList.count == 0 {
            textView.becomeFirstResponder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    @objc private func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /// 发微博
    @objc private func compose() {
        //print(__FUNCTION__)
        guard let token = HMZUserAccountViewModel.shareViewModel.token else{
            SVProgressHUD.showErrorWithStatus("您尚未登陆，请先登录")
            return
        }
        let urlString = "/2/statuses/update.json"
        var param = [String: String]()
        param["access_token"] = token
        param["status"] = textView.fullText()
        
        //发送没有图片的微博
        HMZNetWorkTool.sharedTools.requestJSONDict(HTTPRequestMethod.POST, urlString: urlString, parameters: param) { (result, error) -> () in
            if error != nil {
                SVProgressHUD.showErrorWithStatus(HMZAppErrorTip)
                return
            }
            SVProgressHUD.showSuccessWithStatus("发送成功")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    //MARK: -懒加载
    /// 文本框
    private lazy var textView: HMZEmoticonTextView = {
        let tv = HMZEmoticonTextView()
        tv.font = UIFont.systemFontOfSize(18)
        tv.textColor = UIColor.darkGrayColor()
        //tv.backgroundColor = HMZRandomColor()
        tv.alwaysBounceVertical = true
        //键盘的关闭模式,当拖动的时候关闭键盘
        tv.keyboardDismissMode = .OnDrag
        tv.delegate = self
        return tv
    }()
    /// 占位符
    private lazy var placeholderLabel: UILabel = UILabel(title: "分享新鲜事儿", color: UIColor.lightGrayColor(),fontSize:18)
    /// 工具条
    private lazy var toolBar: UIToolbar = UIToolbar()
    ///  表情键盘
    /// 这里的weak修饰的self ,当self 对象内存回收时，地址会自动置为nil
    private lazy var emoticonKeyBoard: HMZEmoticonKeyboardView = HMZEmoticonKeyboardView { [weak self](em) -> () in
        self?.textView.insertTextWithEmoticon(em)
        
        //解决插入图片之后占位label不隐藏的问题.
        self?.textViewDidChange(self!.textView)
    }
    
    /// 选择图片控制器
    private lazy var selectorPictureVc: HMZPictureSeclectorViewController = {
        let vc = HMZPictureSeclectorViewController()
        vc.collectionView?.backgroundColor = UIColor.darkGrayColor()
        
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
        vc.view.snp_makeConstraints(closure: { (make) -> Void in
            make.left.bottom.right.equalTo(self.view)
            //默认为零 不显示
            make.height.equalTo(0)
        })
        return vc
    }()
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

extension HMZComposeViewController {
    private func setupUI() {
        view.backgroundColor = UIColor.whiteColor()
        setupNav()
        setupTextView()
        setupToolBar()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardFrameWillChange:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    private func setupTextView() {
        view.addSubview(textView)
        textView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(screenH)
        }
        textView.addSubview(placeholderLabel)
        placeholderLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(textView.snp_top).offset(8)
            make.left.equalTo(textView.snp_left).offset(5)
        }
    }
    
    private func setupNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: "cancel")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .Plain, target: self, action: "compose")
        navigationItem.rightBarButtonItem?.enabled = false
        //设置title
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        navigationItem.titleView = v
        let weiboLabel = UILabel(title: "发微博", color: UIColor.darkGrayColor(), fontSize: 17)
        let nameLabel = UILabel(title: HMZUserAccountViewModel.shareViewModel.userName ?? "", color: UIColor.lightGrayColor(), fontSize:14)
        v.addSubview(weiboLabel)
        v.addSubview(nameLabel)
        weiboLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(v.snp_centerX)
            make.top.equalTo(v.snp_top)
        }
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(v.snp_centerX)
            make.bottom.equalTo(v.snp_bottom)
        }
    }
    
    private func setupToolBar() {
        //添加工具按钮
        let itemSettings = [["imageName": "compose_toolbar_picture","actionName":"selectPicture"],
            ["imageName": "compose_mentionbutton_background"],
            ["imageName": "compose_trendbutton_background"],
            ["imageName": "compose_emoticonbutton_background","actionName":"selectEmoticonKeyboard:"],
            ["imageName": "compose_add_background"]]
        var items = [UIBarButtonItem]()
        for dict in itemSettings {
            let btn = UIButton(imageName: dict["imageName"]!, backgroundImage: nil)
            if let action = dict["actionName"] {
                btn.addTarget(self, action: Selector(action), forControlEvents: .TouchUpInside)
            }
            let item = UIBarButtonItem(customView: btn)
            items.append(item)
            let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            items.append(space)
        }
        items.removeLast()
        toolBar.items = items
        view.addSubview(toolBar)
        
        //设置布局
        toolBar.snp_makeConstraints { (make) -> Void in
            make.left.bottom.right.equalTo(self.view)
            make.height.equalTo(40)
        }
    }
}

// MARK: - 监听方法
extension HMZComposeViewController:UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
        placeholderLabel.hidden = textView.hasText()
    }
    
    @objc private func keyboardFrameWillChange(n: NSNotification) {
        //Optional([UIKeyboardFrameBeginUserInfoKey: NSRect: {{0, 736}, {414, 226}}, UIKeyboardCenterEndUserInfoKey: NSPoint: {207, 623}, UIKeyboardBoundsUserInfoKey: NSRect: {{0, 0}, {414, 226}}, UIKeyboardFrameEndUserInfoKey: NSRect: {{0, 510}, {414, 226}}, UIKeyboardAnimationDurationUserInfoKey: 0.25, UIKeyboardCenterBeginUserInfoKey: NSPoint: {207, 849}, UIKeyboardAnimationCurveUserInfoKey: 7, UIKeyboardIsLocalUserInfoKey: 1])
        let duration = n.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! Double
        let rect = (n.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! NSValue).CGRectValue()
        //不知道他是干啥的
        //let curve = n.userInfo!["UIKeyboardAnimationCurveUserInfoKey"] as! Int
        
        //更改toolbar的底部约束
        let offset = -screenH + rect.origin.y
        toolBar.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(offset)
        }
        UIView.animateWithDuration(duration) { () -> Void in
            //强制刷新
            //如果给动画添加动画效果的曲线值 原始值 为 7  对应动画时长失效  ????
            //UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve)!)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func selectPicture() {
        textView.resignFirstResponder()
        
        selectorPictureVc.view.snp_updateConstraints { (make) -> Void in
            make.height.equalTo(226+88+60)
        }
       
        view.bringSubviewToFront(toolBar)
    }
    
    @objc private func selectEmoticonKeyboard(sender: UIButton) {
        
        textView.resignFirstResponder()
        //textView.inputView = textView.inputView == nil ? emoticonKeyBoard : nil
        if textView.inputView == nil {
            textView.inputView = emoticonKeyBoard
            sender.setImage(UIImage(named: "compose_keyboardbutton_background"), forState: .Normal)
            sender.setImage(UIImage(named: "compose_keyboardbutton_background_highlighted"), forState: .Highlighted)
        } else {
            textView.inputView = nil
            sender.setImage(UIImage(named: "compose_emoticonbutton_background"), forState: .Normal)
            sender.setImage(UIImage(named: "compose_emoticonbutton_background_highlighted"), forState: .Highlighted)
        }
        
        
        textView.becomeFirstResponder()
    }
    
}
