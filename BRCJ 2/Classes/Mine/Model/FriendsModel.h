//
//  FriendsModel.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/21.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 {
   "account" : "X13524014030",
   "loginCount" : 0,
   "status" : "0",
   "province" : null,
   "country" : null,
   "nickname" : "至李铭言",
   "updateTime" : "2019-10-12 13:51:02",
   "sex" : null,
   "headPortrait" : null,
   "city" : null,
   "name" : null,
   "delFlag" : "0",
   "id" : 13579147,
   "inviteCode" : "03041042531",
   "email" : null,
   "addTime" : "2019-10-12 13:50:25",
   "mobile" : "13524014030",
   "lastLoginTime" : null,
   "note" : null,
   "passwd" : null,
   "role" : null,
   "createUser" : 13579125,
   "genTime" : null,
   "vipLevel" : "0"
 }
 */

@interface FriendsModel : NSObject

@property(nonatomic,copy)NSString *friendId;
@property(nonatomic,copy)NSString *headPortrait;
@property(nonatomic,copy)NSString *account;
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
@property(nonatomic,copy)NSString *vipLevel;
@end

NS_ASSUME_NONNULL_END
