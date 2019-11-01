//
//  UserInfoModel.h
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MyMember.h"

NS_ASSUME_NONNULL_BEGIN

/**
 "account" : "X18514528955",
 "loginCount" : 114,
 "status" : "0",
 "province" : null,
 "country" : null,
 "nickname" : "okuuu",
 "updateTime" : "2019-08-16 13:22:50",
 "sex" : null,
 "headPortrait" : null,
 "city" : null,
 "name" : null,
 "delFlag" : "0",
 "id" : 13579108,
 "inviteCode" : "55982541581",
 "email" : null,
 "addTime" : "2019-08-16 13:22:50",
 "mobile" : "18514528955",
 "lastLoginTime" : "2019-09-26 16:21:59",
 "note" : null,
 "passwd" : null,
 "role" : null,
 "createUser" : 13579105,
 "genTime" : null
 **/



@interface UserInfoModel : NSObject<NSSecureCoding>

@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *account;
@property(nonatomic,copy)NSString *headPortrait;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *passwd;
@property(nonatomic,copy)NSString *role;
@property(nonatomic,copy)NSString *createUser;
@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *delFlag;
@property(nonatomic,copy)NSString *note;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *province;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *country;
@property(nonatomic,copy)NSString *inviteCode;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *lastLoginTime;
@property(nonatomic,copy)NSString *loginCount;
@property(nonatomic,copy)NSString *genTime;
@property(nonatomic,copy)NSString *updateTime;


// 归档
- (void)saveToFile;
// 解档
+ (UserInfoModel *)readFromFile;
// 删档
+ (void)removeFile;

@end

NS_ASSUME_NONNULL_END
