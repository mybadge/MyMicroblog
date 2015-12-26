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


class HMZMessageCell:UITableViewCell {
    private let imageWidth:CGFloat = 60
    private let margin:CGFloat = 10
    var user: HMZUser?{
        didSet{
            nameLabel.text = user?.name
            desLabel.text = user?.des
            timeLabel.text = user?.created_atStr
            iconView.sd_setImageWithURL(user?.avatar_largeURL)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        nameLabel.textAlignment = .Left
        contentView.addSubview(timeLabel)
        contentView.addSubview(desLabel)
        
        //desLabel.preferredMaxLayoutWidth = screenW - imageWidth - 3*margin
        desLabel.textAlignment = .Left
        
        contentView.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(imageWidth + 2*margin)
        }
        //添加约束
        iconView.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(self).offset(margin)
            make.height.width.equalTo(imageWidth)
        }
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconView.snp_right).offset(margin)
            make.top.equalTo(iconView.snp_top)
        }
        desLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconView.snp_right).offset(margin)
            make.top.equalTo(nameLabel.snp_bottom).offset(margin)
            make.right.equalTo(self.snp_right).offset(-margin)
        }
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(nameLabel.snp_right).offset(margin)
            //为什么显示有问题
            make.right.equalTo(self.snp_right).offset(-margin)
            make.top.equalTo(self.snp_top).offset(margin)
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 头像
    private lazy var iconView: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 30
        v.layer.masksToBounds = true
        return v
    }()
    /// 名称
    private lazy var nameLabel: UILabel = UILabel(title: "大家好", color: UIColor.blackColor(), fontSize: 15)
    /// 创建时间
    private lazy var timeLabel: UILabel = UILabel(title: "11.11", color: UIColor.grayColor(), fontSize: 12)
    /// 描述
    private lazy var desLabel: UILabel = UILabel(title: "火星", color: UIColor.grayColor(), fontSize: 12)

}
