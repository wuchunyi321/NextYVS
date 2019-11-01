//
//  MyMember.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/13.
//  Copyright © 2019 cy. All rights reserved.
//

/**
 "userId": 13579104,
 "vipLevel": "0",
 "vipLevelName": null,
 "addTime": null,
 "updateTime": null,
 "mid": null
 **/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyMember : NSObject<NSSecureCoding>

@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *vipLevel;
@property(nonatomic,copy)NSString *vipLevelName;
@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *updateTime;
@property(nonatomic,copy)NSString *mid;

// 归档
- (void)saveToFile;
// 解档
+ (MyMember *)readFromFile;

// 删档
+ (void)removeFile;

@end

NS_ASSUME_NONNULL_END
