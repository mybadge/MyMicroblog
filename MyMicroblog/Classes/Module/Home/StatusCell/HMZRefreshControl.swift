//
//  HMZRefreshControl.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/23.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit


///  刷新控件状态
enum HMZRefreshState: String {
    /// 正常状态
    case Normal = "Normal"
    /// 正在下拉
    case Pulling = "Pulling"
    /// 正在刷新
    case Refreshing = "Refreshing"
}

class HMZRefreshControl: UIControl {
    let refreshViewHeight:CGFloat = 50
    var oldState: HMZRefreshState = .Normal
    /// 不能用state 会和系统重名 所以用refreshState
    var refreshState: HMZRefreshState = .Normal {
        didSet {
            switch refreshState {
            case .Pulling:
                print("下拉刷新")
                tipLabel.text = "放开刷新"
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.arrowIcon.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                })
            case .Refreshing:
                tipLabel.text = "正在刷新..."
                arrowIcon.hidden = true
                loadingIcon.startAnimating()
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    var inset = self.scrollView!.contentInset
                    inset.top += self.refreshViewHeight
                    self.scrollView?.contentInset = inset
                })
                //主动触发刷新事件
                sendActionsForControlEvents(.ValueChanged)
                
            case .Normal:
                tipLabel.text = "下拉刷新"
                arrowIcon.hidden = false
                loadingIcon.stopAnimating()
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.arrowIcon.transform = CGAffineTransformIdentity
                })
                
                //从刷仙状态切换到默认状态下会执行下面的代码
                if oldState == .Refreshing {
                    //修改父视图的contentInset
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        var inset = self.scrollView!.contentInset
                        inset.top -= self.refreshViewHeight
                        self.scrollView?.contentInset = inset
                    })
                }
            }
            
            //记录当前的状态
            oldState = refreshState
        }
    }
   
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        //获取刷新的临界值 根据父视图的偏移量 来判断需要执行的操作
        let offset = scrollView?.contentOffset
        let contentInsetTop = scrollView?.contentInset.top ?? 0
        //视图移动的临界值
        let condationValue = -contentInsetTop - refreshViewHeight
        //获取到父视图的位移 根据位移 来判断需要执行的对应的操作
        //在父视图拖动的情况下 且刷新控件在正常状态,位移还在临界值范围之内,就进入刷新状态
        if scrollView!.dragging {
            if refreshState == .Normal && offset?.y < condationValue {
                //进入刷新状态
                refreshState = .Pulling
            } else if refreshState == .Pulling && offset?.y > condationValue {
                refreshState = .Normal
            }
        } else {
            //停止拽动 如果当钱状态是正在下拉的状态 就执行刷新的操作
            if refreshState == .Pulling {
                refreshState = .Refreshing
            }
        }
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        if let sv = newSuperview as? UIScrollView {
            self.scrollView = sv
            //KVO 监听scrollView 的偏移量
            self.scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
        }
    }
    
    //停止刷新,共外界调用
    func stopRefreshing() {
        refreshState = .Normal
    }
    
    deinit {
        self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    override init(frame: CGRect) {
        let frame = CGRect(x: 0, y: -refreshViewHeight, width: screenW, height: refreshViewHeight)
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(arrowIcon)
        addSubview(tipLabel)
        addSubview(loadingIcon)
        
        arrowIcon.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX).offset(-35)
            make.centerY.equalTo(self.snp_centerY)
        }
        tipLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.arrowIcon.snp_right).offset(5)
            make.centerY.equalTo(self.snp_centerY)
        }
        loadingIcon.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(arrowIcon.snp_center)
        }
    }
    
    
    var scrollView: UIScrollView?
    private lazy var arrowIcon:UIImageView = UIImageView(image: UIImage(named: "tableview_pull_refresh"))
    private lazy var tipLabel: UILabel = UILabel(title: "下拉刷新", color: UIColor.lightGrayColor(), fontSize: 14)
    private lazy var loadingIcon: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
}
