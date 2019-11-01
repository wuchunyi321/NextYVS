//
//  NewUser.h
//  TSQ
//
//  Created by wuchunyi on 16/9/2.
//  Copyright © 2016年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewUser : NSObject


@property (nonatomic,copy)NSNumber  *province_id;
@property (nonatomic,copy)NSNumber  *city_id;
@property (nonatomic,copy)NSNumber  *district_id;
@property (nonatomic,copy)NSNumber  *town_id;
@property (nonatomic,copy)NSNumber  *community_id;

@property (nonatomic,copy)NSString  *province_name;
@property (nonatomic,copy)NSString  *city_name;
@property (nonatomic,copy)NSString  *district_name;
@property (nonatomic,copy)NSString  *town_name;
@property (nonatomic,copy)NSString  *community_name;


@property (nonatomic,copy)NSString  *auth_key;
@property (nonatomic,copy)NSString  *home_address;
@property (nonatomic,copy)NSNumber  *id;
@property (nonatomic,copy)NSString  *image;
@property (nonatomic,copy)NSString  *nick_name;
@property (nonatomic,copy)NSString  *password;
@property (nonatomic,copy)NSString  *phone_number;

@property (nonatomic,copy)NSString  *real_name;
@property (nonatomic,copy)NSString  *regist_date;
@property (nonatomic,copy)NSString  *user_name;
@property (nonatomic,copy)NSNumber  *user_state_now;
@property (nonatomic,copy)NSString  *qr_image;
@property (nonatomic,copy)NSArray   *docInfoDtoList;

// 归档
- (void)saveToFile;

// 解档
+ (NewUser *)readFromFile;

// 删档
+ (void)removeFile;


@end
