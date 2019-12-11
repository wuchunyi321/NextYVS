//
//  TransferDataTool.m
//  BRCJ
//
//  Created by wuchunyi on 2019/10/25.
//  Copyright © 2019 cy. All rights reserved.
//

#import "TransferDataTool.h"

#import "UserInfoModel.h"
#import "MyMember.h"
#import "AcountModel.h"

#import "JKDirectoryManager.h"

#import "WXApiManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApiRequestHandler.h"

@implementation TransferDataTool

//userInfo
+ (void)writeUserInfo:(UserInfoModel *)item{
    NSError *error;
    //会调用对象的encodeWithCoder方法
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:item
                                         requiringSecureCoding:YES
                                                         error:&error];
    [data writeToFile:[JKDirectoryManager loginInfoFilePath] atomically:YES];
}
+ (void)removeUserInfo{
    [UserInfoModel removeFile];
}
//member
+ (void)writeMember:(MyMember *)item{
    NSError *error;
    //会调用对象的encodeWithCoder方法
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:item
                                         requiringSecureCoding:YES
                                                         error:&error];
    NSLog(@"the error == %@",error);
    [data writeToFile:[JKDirectoryManager memberInfoFilePath] atomically:YES];
}
+ (void)removeMember{
    [MyMember removeFile];
}
//acount
+ (void)writeAcount:(AcountModel *)item{
    NSError *error;
    //会调用对象的encodeWithCoder方法
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:item
                                         requiringSecureCoding:YES
                                                         error:&error];
    NSLog(@"the error == %@",error);
    [data writeToFile:[JKDirectoryManager accountInfoFilePath] atomically:YES];
}
+ (void)removeAcount{
    [AcountModel removeFile];
}

//token
+ (void)writeToken:(NSString *)token{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:token forKey:@"innerToken"];
    [ud synchronize];
}

+ (void)clearLoginInfo{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"" forKey:@"innerToken"];
    [UserInfoModel removeFile];
    [MyMember removeFile];
    [AcountModel removeFile];
}
/**
 是否安装微信
 */
+ (BOOL)isWXAppInstalled{
    return [WXApi isWXAppInstalled];
}
/**
 微信注册
 */
+ (void)registWX{
    [WXApi startLogByLevel:WXLogLevelNormal logBlock:^(NSString *log) {
        NSLog(@"log : %@", log);
    }];
    //向微信注册,发起支付必须注册
    [WXApi registerApp:@"wx80163dd2d39f73b3" enableMTA:YES];
}

/**
 支付宝跳转
 */
+ (void)zfbPayWith:(NSString *)payInfo{
    NSString *appScheme = @"BRCJ";
    [[AlipaySDK defaultService] payOrder:payInfo fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
    }];
}
/**
 微信跳转
 */
+ (void)wxPayWith:(NSDictionary *)payInfo{
    [WXApiRequestHandler jumpToBizPayWithStr:payInfo];
}

@end
