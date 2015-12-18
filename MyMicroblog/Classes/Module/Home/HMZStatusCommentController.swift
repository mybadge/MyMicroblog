//
//  HMZStatusCommentController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/18.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SVProgressHUD

class HMZStatusCommentController: UITableViewController {
    /// 要查看评论微博的Id
    var statusId: Int?
    private lazy var comments = [HMZStatusComment]()
    private let commentCellId = "commentCellId"
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.showWithStatus("哥正在努力加载中。。。")
        
        tableView.registerClass(HMZCommentCell.self, forCellReuseIdentifier: commentCellId)
        //let headView = HMZStatusOriginalView()
        //headView.status =
        //tableView.tableHeaderView = headView
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func loadData() {
        HMZStatusCommentViewModel.loadData(statusId ?? 0) { (list) -> () in
            
            SVProgressHUD.dismiss()
            
            guard let commentList = list else {
                SVProgressHUD.showErrorWithStatus(HMZAppErrorTip)
                return
            }
            
            self.comments = commentList
            self.tableView.reloadData()
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else {
            return comments.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = HMZStatusCell()
            if comments.count > 0 {
                cell.status = comments[0].status
                //怎么在这里给toolBar更改frame,把它调小
                cell.toolBar.frame = CGRect(x: 50, y: 0, width: 300, height: 30)
                cell.toolBar.userInteractionEnabled = false
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(commentCellId, forIndexPath: indexPath) as! HMZCommentCell
            
            cell.comment = comments[indexPath.row]
            
            return cell
        }
    }
}
