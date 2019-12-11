//
//  TransferDataTool.h
//  BRCJ
//
//  Created by wuchunyi on 2019/10/25.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UserInfoModel;
@class MyMember;
@class AcountModel;

@interface TransferDataTool : NSObject

//userInfo
+ (void)writeUserInfo:(UserInfoModel *)item;
+ (void)removeUserInfo;
//member
+ (void)writeMember:(MyMember *)item;
+ (void)removeMember;
//acount
+ (void)writeAcount:(AcountModel *)item;
+ (void)removeAcount;
//token
+ (void)writeToken:(NSString *)token;
/**
 清空登录信息
 */
+ (void)clearLoginInfo;
/**
 是否安装微信
 */
+ (BOOL)isWXAppInstalled;
/**
 微信注册
 */
+ (void)registWX;
/**
 支付宝跳转
 */
+ (void)zfbPayWith:(NSString *)payInfo;
/**
 微信跳转
 */
+ (void)wxPayWith:(NSDictionary *)payInfo;

@end

NS_ASSUME_NONNULL_END
