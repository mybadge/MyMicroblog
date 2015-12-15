//
//  HMZHomeViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/12.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

class HMZHomeViewController: HMZBaseTableViewController {

    ///  添加微博模型数据
   lazy var statuses = [HMZStatus]()
    private let homeCellId = "homeCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !userLoginState {
            visitorLoginView?.setupInfo("关注一些人，回这里看看有什么惊喜", imageName: nil)
            return
        }
        
        prepareTableView()
    }

    
    // MARK: -准备tableView
    private func prepareTableView() {
        //注册 tableViewCell
        tableView.registerClass(HMZStatusCell.self, forCellReuseIdentifier: homeCellId)
        //设置预估行高
        tableView.estimatedRowHeight = 300
        //设置行高自动计算
        tableView.rowHeight = UITableViewAutomaticDimension//Automatic:自动 Dimension:尺寸
        //separator: 分离器
        tableView.separatorStyle = .None
        
        //刷新控件
        refreshControl = UIRefreshControl()
        //添加刷新事件
        refreshControl?.addTarget(self, action: "", forControlEvents: .ValueChanged)
        
        //添加文案提示
        
    }
    
    
    
    
    // MARK: - Table view 数据源
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(homeCellId, forIndexPath: indexPath) as! HMZStatusCell

        cell.status = statuses[indexPath.row]
        return cell
    }


    

}
