//
//  AppDelegate.h
//  BRCJ
//
//  Created by wuchunyi on 2019/7/12.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,assign)BOOL allowRotation;

- (void)setAlias;
- (void)deleteAlias;
@end

