//
//  HMZWebViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/16.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SVProgressHUD

class HMZWebViewController: UIViewController,UIWebViewDelegate {

    let webView = UIWebView()
    var urlString: String?
    override func loadView() {
        view = webView
        webView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = urlString {
            let request = NSURLRequest(URL: NSURL(string: url)!)
            webView.loadRequest(request)
            webView.sizeToFit()
        }
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    deinit {
        SVProgressHUD.dismiss()
    }
}
