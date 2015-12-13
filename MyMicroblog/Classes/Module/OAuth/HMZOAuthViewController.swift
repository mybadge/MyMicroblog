//
//  HMZOAuthViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/13.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SVProgressHUD

class HMZOAuthViewController: UIViewController {
    private let webView = UIWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = HMZRandomColor()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "close")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .Plain, target: self, action: "defaultAccount")
        
        loadOAuthPage()
    }
    
    override func loadView() {
        view = webView
        webView.delegate = self
    }
    
    private func loadOAuthPage() {
        let URLString = NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(HMZApiClient_id)&redirect_uri=\(HMZApiRedirect_uri)")
        if let url = URLString {
            let request = NSURLRequest(URL: url)
            webView.loadRequest(request)
            
        }
    }
    
}

extension HMZOAuthViewController: UIWebViewDelegate {
    func defaultAccount() {
        print("defaultAccount")
        let jsString = "document.getElementById('userId').value = '18511584983', document.getElementById('passwd').value = 'zhao558123';  "
        webView.stringByEvaluatingJavaScriptFromString(jsString)
    }
    func close() {
        SVProgressHUD.dismiss()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let urlString = request.URL?.absoluteString ?? ""
        
        //print(urlString)
        
        //屏蔽掉不希望加载的页面
        if urlString.hasPrefix("https://api.weibo.com/") {
            return true
        }
        
        if !urlString.hasPrefix(HMZApiRedirect_uri) {
            //如果url没有包含回调地址,则返回, 因为他不是授权成功回调的..
            return false
        }

        
        
        //获取授权码  query 是请求参数列表
        guard let query = request.URL?.query else {
            //获取不到参数列表
            return false
        }
        print(query)
        let codeStr = "code="
        let code = query.substringFromIndex(codeStr.endIndex)
        print("code=\(code)")
        HMZUserAccountViewModel().getAccessToken(code) { (error) -> () in
            if error != nil {
                //网络请求失败
                SVProgressHUD.showErrorWithStatus(HMZAppErrorTip)
                return
            }
            
            self.dismissViewControllerAnimated(false, completion: { () -> Void in
                print("登陆成功")
            })
        }
        
        return false
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        //SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        //SVProgressHUD.dismiss()
    }
    
    
    
    
    
    
    
}