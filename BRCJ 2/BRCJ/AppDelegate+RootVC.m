//
//  AppDelegate+RootVC.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/19.
//  Copyright © 2019 cy. All rights reserved.
//

#import "AppDelegate+RootVC.h"

#import "BRNavigationController.h"
#import "BRTabBarViewController.h"
#import "BRNormalBarController.h"
#import "LoginViewController.h"

@implementation AppDelegate (RootVC)

- (void)setAppWindow{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
}
//未登陆时候
- (void)setLoginViewController{
    LoginViewController  *login = [[LoginViewController alloc] init];
    BRNavigationController *nav = [[BRNavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = nav;
}

- (void)setRootViewControllers{
    BRNormalBarController  *tab = [[BRNormalBarController alloc] init];
    self.window.rootViewController = tab;
}

//
- (void)setMemberRootViewControllers{
    BRTabBarViewController  *tab = [[BRTabBarViewController alloc] init];
    self.window.rootViewController = tab;
}


@end
