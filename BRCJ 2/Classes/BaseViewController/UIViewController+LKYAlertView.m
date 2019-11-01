//
//  UIViewController+LKYAlertView.m
//  lky
//
//  Created by wzn on 15/4/27.
//  Copyright (c) 2015年 znyb. All rights reserved.
//

#import "UIViewController+LKYAlertView.h"
#import <QuartzCore/QuartzCore.h>

@interface UIViewController(LKYModelInternal)
- (UIView *)parentTarget;
@end

@implementation UIViewController(LKYModelInternal)

- (UIView *)parentTarget{
    UIViewController  *tagert = self;
    while (tagert.parentViewController != nil) {
        tagert = tagert.parentViewController;
    }
    return tagert.view;
}

@end

@implementation UIViewController (LKYAlertView)

//新的界面处理
- (void)presentNewViewController:(UIViewController *)vc{
    UIView  *vcView = vc.view;
    UIView  *taget = [self parentTarget]; //父视图
    vcView.tag = 888; //需要铺上去的视图
    if (![taget.subviews containsObject:vcView]){
        CGRect visibleFrame = CGRectMake(0, 200+TopStatus, SCREEN_WIDTH, SCREEN_HEIGHT-200-TopStatus-BottomHeight);
        vcView.frame =visibleFrame;
        [taget addSubview:vcView];
    }
}

- (void)dismissNewModel{
    UIView *target = [self parentTarget];
    [UIView animateWithDuration:LKYAnimationDuration animations:^{
        UIView *model = [target.subviews objectAtIndex:target.subviews.count -1];
        [model removeFromSuperview];
    }];
}

@end
