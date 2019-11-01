//
//  UIViewController+LKYAlertView.h
//  lky
//
//  Created by wzn on 15/4/27.
//  Copyright (c) 2015年 znyb. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LKYAnimationDuration   0.3

@interface UIViewController (LKYAlertView)

//新的界面处理
-(void)presentNewViewController:(UIViewController *)vc;
-(void)dismissNewModel;


@end
