//
//  HMZComposeViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/17.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class HMZComposeViewController: UIViewController {
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
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
    
    //懒加载
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
    private lazy var placeholderLabel: UILabel = UILabel(title: "分享新鲜事儿", color: UIColor.lightGrayColor(),fontSize:18)
}

extension HMZComposeViewController {
    private func setupUI() {
        view.backgroundColor = UIColor.whiteColor()
        setupNav()
        setupTextView()
    }
    
    private func setupTextView() {
        view.addSubview(textView)
        textView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(screenH / 2)
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
}

extension HMZComposeViewController:UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
        placeholderLabel.hidden = textView.hasText()
    }
}
