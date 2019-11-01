//
//  AppDelegate+RootVC.h
//  BRCJ
//
//  Created by wuchunyi on 2019/7/19.
//  Copyright © 2019 cy. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (RootVC)

- (void)setAppWindow;
//未登陆时候
- (void)setLoginViewController;

- (void)setMemberRootViewControllers;
@end

NS_ASSUME_NONNULL_END
