//
//  CQBlockAlertView.h
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/6.
//  Copyright © 2018年 Caiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQBlockAlertView : UIView

/**
 带block回调的弹窗
 */
+ (void)alertWithButtonClickedBlock:(void (^)(void))buttonClickedBlock;

/**
 不带回调的弹窗
 */
+(void)alertShowWithType:(NSInteger)grade
             VXBackBlock:(void (^)(void))vxBlock
            ZFBBackBlock:(void (^)(void))zfbBlock;

@end
