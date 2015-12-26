//
//  HMZDropdownMenu.m
//  MyMicroblog
//
//  Created by 赵志丹 on 15/12/25.
//  Copyright © 2015年 赵志丹. All rights reserved.
//

#import "HMZDropdownMenu.h"

//@implementation HMZDropdownMenu


@interface HMZDropdownMenu ()

@property (nonatomic,weak) UIImageView *containerView;
@end
@implementation HMZDropdownMenu

+ (instancetype)menu{
    return  [[self alloc] init];
}

- (UIImageView *)containerView{
    if (!_containerView) {
        UIImageView *containerView = [[UIImageView alloc] init];
        _containerView = containerView;
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
    }
    return _containerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setContent:(UIView *)content{
    _content = content;
    CGRect frame = content.frame;
    frame = CGRectMake(10, 15, frame.size.width, frame.size.height);
    content.frame = frame;
//    content.x = 10;
//    content.y = 15;
//    //设置灰色的高度
//    self.containerView.height = CGRectGetMaxY(content.frame) + 11;
//    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    CGRect f = self.containerView.frame;
    f = CGRectMake(f.origin.x, f.origin.y, CGRectGetMaxX(content.frame) + 10, CGRectGetMaxY(content.frame) + 11);
    self.containerView.frame = f;
    [self.containerView addSubview:content];
}

- (void)showFrom:(UIView *)from{
    //1.获取最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    //2.把自己添加到窗口上
    [window addSubview:self];
    
    //3.设置尺寸
    self.frame = window.bounds;
    //4.转换坐标系
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    
    CGRect f = self.containerView.frame;
    //CGPoint p = self.containerView.center;
    CGFloat centerX = CGRectGetMidX(newFrame);
    CGFloat centerY = CGRectGetMaxY(newFrame) + f.size.height * 0.5;
    self.containerView.center = CGPointMake(centerX, centerY);
    //self.containerView.centerX = CGRectGetMidX(newFrame);
    //self.containerView.y = CGRectGetMaxY(newFrame);
    
    //5.通知外界,自己显示了
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]){
        [self.delegate dropdownMenuDidShow:self];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

- (void)dismiss{
    [self removeFromSuperview];
    //通知外界自己要销毁了
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]){
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

- (void)setContentController:(UIViewController *)contentController{
    _contentController = contentController;
    self.content = contentController.view;
}
@end
