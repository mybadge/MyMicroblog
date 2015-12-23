//
//  HMZHomeViewController.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/12.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit
import SVProgressHUD

class HMZHomeViewController: HMZBaseTableViewController {
    
    private let homeCellId = "homeCellId"
    ///  添加微博模型数据
    lazy var statuses = [HMZStatus]()
    /// 指示器视图
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        return indicator
    }()
    /// 提示内容label
    private lazy var tipLabel: UILabel = {
        let tip = UILabel()
        tip.frame = CGRectMake(0, -64, screenW, 44)
        tip.backgroundColor = HMZThemeColor
        tip.textAlignment = .Center
        return tip
    }()
///  刷新控件
    private lazy var refreshView: HMZRefreshControl = HMZRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !userLoginState {
            visitorLoginView?.setupInfo("关注一些人，回这里看看有什么惊喜", imageName: nil)
            return
        }
        
        loadData()
        SVProgressHUD.showWithStatus("哥正在努力加载中", maskType: .Gradient)
        prepareTableView()
        setupNav()
    }
    
    private func setupNav() {
        /* 设置导航栏上面的内容 */
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton(imageName: "navigationbar_friendattention", backgroundImage: nil))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIButton(imageName: "navigationbar_icon_radar", backgroundImage: nil))
        
    }
    
    // MARK: -准备tableView
    ///  设置TableView一些必要的属性
    private func prepareTableView() {
        
        //注册 tableViewCell
        tableView.registerClass(HMZStatusCell.self, forCellReuseIdentifier: homeCellId)
        //tableView.rowHeight = 200
        // 设置预估行高
        tableView.estimatedRowHeight = 300
        //设置行高自动计算
        tableView.rowHeight = UITableViewAutomaticDimension//Automatic:自动 Dimension:尺寸
        //separator: 分离器
        tableView.separatorStyle = .None
        
        //刷新控件
        self.tableView.addSubview(refreshView)
        //添加刷新事件
        refreshView.addTarget(self, action: "loadData", forControlEvents: .ValueChanged)
        
        //添加文案提示
        navigationController?.navigationBar.addSubview(tipLabel)
        navigationController?.navigationBar.sendSubviewToBack(tipLabel)
        
    }
    
    ///用ViewModel 去网络上加载数据
    @objc private func loadData() {
        refreshControl?.beginRefreshing()
        //如果既=同时指定 since_id, max_id 服务不会返回任何数据
        var sinceId = 0
        var maxId = 0
        if indicatorView.isAnimating() {
            //上拉加载更多
            sinceId = 0
            maxId = statuses.last!.id ?? 0
        }else {
            sinceId = statuses.first?.id ?? 0
            maxId = 0
        }
        
        HMZStatusViewModel.loadData(sinceId, maxId: maxId) { (statuses) -> () in
            self.refreshView.stopRefreshing()
            guard let list = statuses else{
                SVProgressHUD.showErrorWithStatus("服务器出错了,请稍后再试")
                return
            }
            
            if maxId > 0 {
                //上拉加载更多
                self.statuses += list
                self.indicatorView.stopAnimating()
                
            }else if sinceId > 0 {//下拉加载
                self.statuses = list + self.statuses
                self.indicatorView.stopAnimating()
                //动画提示加载了新数据
                self.showTipAnimation(list.count)
            }else {//首次加载
                self.statuses = list
            }
            SVProgressHUD.dismiss()
            //NSLog("加载完成")
            self.tableView.reloadData()
        }
    }
    
    private func showTipAnimation(count:Int) {
        let tip = count == 0 ? "当前数据已经是最新的了" : "共加载了\(count)条新微博"
        tipLabel.text = tip
        //记录原来的位置
        let rect = tipLabel.frame
        UIView.animateWithDuration(1, animations: { () -> Void in
            //修改frame
            self.tipLabel.frame = CGRect(x: 0, y: 44, width: screenW, height: 44)
            }) { (_) -> Void in
                UIView.animateWithDuration(1, delay: 1.2, options: [], animations: { () -> Void in
                    self.tipLabel.frame = rect
                    }, completion: { (_) -> Void in
                        print("ok")
                })
        }
    }
    
    
    // MARK: - Table view 数据源
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(homeCellId, forIndexPath: indexPath) as! HMZStatusCell
        cell.status = statuses[indexPath.row]
        if indexPath.row == statuses.count - 1 && !indicatorView.isAnimating() {
            //这句话千万不能漏掉,否则很严重(他会一直想服务器发送数据,紧接着就会Error Domain=com.alamofire.error.serialization.response Code=-1011 "Request failed: forbidden (403)")
            //User requests out of rate limit	用户请求频次超过上限
            indicatorView.startAnimating()
            loadData()
            print("默默加载")
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let contentVc = HMZStatusCommentController()
        contentVc.status = statuses[indexPath.row]
        navigationController?.pushViewController(contentVc, animated: true)
    }
}
