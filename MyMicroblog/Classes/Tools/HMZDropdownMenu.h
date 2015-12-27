//
//  HMZDropdownMenu.h
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/25.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMZDropdownMenu;

@protocol HMZDropdownMenuDelegate <NSObject>

@optional
- (void)dropdownMenuDidShow:(HMZDropdownMenu *)menu;
- (void)dropdownMenuDidDismiss:(HMZDropdownMenu *)menu;


@end

@interface HMZDropdownMenu : UIView

/**
 *  内容视图
 */
@property (nonatomic,strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic,strong) UIViewController *contentController;

@property (nonatomic,weak) id<HMZDropdownMenuDelegate> delegate;

+ (instancetype)menu;

/**
 *  显示
 *
 *  @param from 来自那个页面
 */
- (void)showFrom:(UIView *)from;

/**
 *  销毁
 */
- (void)dismiss;
@end




                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                                         
