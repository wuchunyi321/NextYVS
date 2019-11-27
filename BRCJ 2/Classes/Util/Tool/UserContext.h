//
//  UserContext.h
//  BRCJ
//
//  Created by wuchunyi on 2019/7/29.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class NewUser;

@interface UserContext : NSObject

//获取Str的高度
+ (CGFloat) getTheHeightOfStr:(NSString *)str withWidth:(CGFloat)width AndFont:(CGFloat)font;

//获取时间戳
+ (NSString *)ddpGetExpectTimestamp:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;

//判断是不是手机号
+ (BOOL)ischeckPhoneNumber:(NSString *)number;

+ (UIFont *)getTheFontWithName:(NSString *)fontName size:(CGFloat)size;

//token
+(void)setAccessToken:(NSString *)token;
+(NSString *)getAccessToken;

//TestUID
+ (void)setUID:(NSNumber *)UID;
+ (NSNumber *)getUID;

//Test药师基本信息
+ (void)setUserInfo:(NewUser *)model;
+ (NewUser *)getUserInfo;

/** 判断登录状态+ 清空登录状态 **/
+ (BOOL)isLogin;
+ (void)clearLogin;

/**
 保存订单号
 */
+ (void)setOrderNumber:(NSString *)orderNum;
+ (NSString *)getOrderNumber;

@end

NS_ASSUME_NONNULL_END
