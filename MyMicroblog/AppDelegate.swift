//
//  AppDelegate.swift
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/12.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        window?.rootViewController = defaultRootViewController()
        window?.makeKeyAndVisible()
        //设置主题颜色
        setThemeColor()
        
        //注册通知
        registerNotification()
        
        return true
    }
    
    private func defaultRootViewController() -> UIViewController{
        //判断登录状态
        if HMZUserAccountViewModel.shareViewModel.userLoginState {
            if isNewVersion() {//是新版本 进入新特性界面
                return HMZNewFeatureViewController()
            }
            //否则进入欢迎界面
            return HMZWelcomeViewController()
        }
        //进入主界面的访客视图
        return HMZMainTabBarController()
    }
    
    private func isNewVersion() ->Bool {
        //待实现判断版本
        //当前版本
        let dict = NSBundle.mainBundle().infoDictionary
        let currentVersion = dict!["CFBundleShortVersionString"]!.doubleValue
        
        //获取上一个版本
        let CFBundleVersionKey = "CFBundleShortVersionString"
        let userDefault = NSUserDefaults.standardUserDefaults()
        let lastVersion = userDefault.doubleForKey(CFBundleVersionKey)
        userDefault.setDouble(currentVersion, forKey: CFBundleVersionKey)
        userDefault.synchronize()

        return currentVersion > lastVersion
    }
    
    
    @objc private func switchRootVC(n: NSNotification) {
        window?.rootViewController = n.object == nil ? HMZMainTabBarController() : HMZWelcomeViewController()
    }
    
    private func registerNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchRootVC:", name: HMZSwitchRootVCNotificationKey, object: nil)
    }
    //移除通知  析构方法移除通知
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    
    
    
    
    
    
    
    
    
    func setThemeColor() {
        //一定要提前设置
        UINavigationBar.appearance().tintColor = HMZThemeColor
        UITabBar.appearance().tintColor = HMZThemeColor
    }
    
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

