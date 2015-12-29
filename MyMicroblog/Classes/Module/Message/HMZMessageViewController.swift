//
//  HMZMessageViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/12.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SVProgressHUD
import SnapKit
import SDWebImage

class HMZMessageViewController: HMZBaseTableViewController {
    let messageCellId = "messageCellId"
    var users: [HMZUser]?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        SVProgressHUD.showWithStatus("哥正在努力加载中。。。",maskType: .Gradient)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visitorLoginView?.setupInfo("登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", imageName: "visitordiscover_image_message")
        //        let menu = HMZDropdownMenu(frame: CGRect(x: 10, y: 30, width: 100, height: 100))
        //        menu.content
        
        let btn = UIButton(title: HMZUserAccountViewModel.shareViewModel.userName ?? "", backgroundImage: nil, color: UIColor.redColor())
        btn.addTarget(self, action: "titleBtnClick:", forControlEvents: .TouchUpInside)
        navigationItem.titleView = btn
        
        prepareTabView()
    }
    
    @objc private func titleBtnClick(btn: UIButton) {
        //        MMBDropdownMenu *menu = [MMBDropdownMenu menu];
        //        menu.delegate = self;
        //        MMBTitleMenuViewController *titleMenuVc = [[MMBTitleMenuViewController alloc] init];
        //        titleMenuVc.view.width = 150;
        //        titleMenuVc.view.height = 150;
        //        menu.contentController = titleMenuVc;
        //        [menu showFrom:sender];
        
        let menu = HMZDropdownMenu()
        menu.delegate = self
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        myView.backgroundColor = UIColor.redColor()
        menu.content = myView
        menu.showFrom(btn)
        
    }
    
    private func prepareTabView() {
        tableView.registerClass(HMZMessageCell.self, forCellReuseIdentifier: messageCellId)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        //刷新控件
        refreshControl = UIRefreshControl()
        //添加刷新事件
        refreshControl?.addTarget(self, action: "loadData", forControlEvents: .ValueChanged)
    }
    
    @objc private func loadData() {
        HMZUserViewModel.loadData { (list) -> () in
            guard let userList = list else {
                return
            }
            self.users = userList
            //print(userList)
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }
    }
}

extension HMZMessageViewController: HMZDropdownMenuDelegate {
    
}


extension HMZMessageViewController {
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(messageCellId, forIndexPath: indexPath) as! HMZMessageCell
        cell.user = users![indexPath.row]
        return cell
    }
}



