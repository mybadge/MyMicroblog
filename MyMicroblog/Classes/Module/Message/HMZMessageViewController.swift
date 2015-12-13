//
//  HMZMessageViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/12.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

class HMZMessageViewController: HMZBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        visitorLoginView?.setupInfo("登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", imageName: "visitordiscover_image_message")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
