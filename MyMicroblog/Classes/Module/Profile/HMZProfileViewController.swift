//
//  HMZProfileViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/12.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

class HMZProfileViewController: HMZBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        visitorLoginView?.setupInfo("登录后，你的微博、相册、个人资料会显示在这里，展示给别人", imageName: "visitordiscover_image_profile")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注销", style: .Plain, target: self, action: "signOut")

        // Do any additional setup after loading the view.
    }

    @objc private func signOut() {
        let account = HMZUserAccountViewModel.shareViewModel.account
        account?.access_token = nil
        account?.saveAccount()
        NSNotificationCenter.defaultCenter().postNotificationName(HMZSwitchRootVCNotificationKey, object: nil)
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
