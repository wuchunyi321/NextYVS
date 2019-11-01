//
//  NewUser.m
//  TSQ
//
//  Created by wuchunyi on 16/9/2.
//  Copyright © 2016年 cy. All rights reserved.
//
#import "NewUser.h"
#import "JKDirectoryManager.h"

@implementation NewUser

- (id)initWithCoder: (NSCoder *)coder{
    if (self = [super init]){
        self.id = [coder decodeObjectForKey:@"_id"];
        self.real_name = [coder decodeObjectForKey:@"_real_name"];
        self.user_name = [coder decodeObjectForKey:@"_user_name"];
        self.image = [coder decodeObjectForKey:@"_image"];
        self.phone_number = [coder decodeObjectForKey:@"_phone_number"];
        
        self.regist_date= [coder decodeObjectForKey:@"_regist_date"];
        self.user_state_now = [coder decodeObjectForKey:@"_user_state_now"];
        self.password = [coder decodeObjectForKey:@"_password"];
        self.nick_name =  [coder decodeObjectForKey:@"_nick_name"];
        self.auth_key  =   [coder decodeObjectForKey:@"_auth_key"];
        self.home_address =  [coder decodeObjectForKey:@"_home_address"];
        self.qr_image =  [coder decodeObjectForKey:@"_qr_image"];
        self.docInfoDtoList = [coder decodeObjectForKey:@"_docInfoDtoList"];
        
        self.province_id = [coder decodeObjectForKey:@"_province_id"];
        self.city_id = [coder decodeObjectForKey:@"_city_id"];
        self.district_id = [coder decodeObjectForKey:@"_district_id"];
        self.town_id = [coder decodeObjectForKey:@"_town_id"];
        self.community_id = [coder decodeObjectForKey:@"_community_id"];
        
        self.province_name = [coder decodeObjectForKey:@"_province_name"];
        self.city_name = [coder decodeObjectForKey:@"_city_name"];
        self.district_name = [coder decodeObjectForKey:@"_district_name"];
        self.town_name = [coder decodeObjectForKey:@"_town_name"];
        self.community_name = [coder decodeObjectForKey:@"_community_name"];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder{
    [coder encodeObject:_id forKey:@"_id"];
    [coder encodeObject:_real_name forKey:@"_real_name"];
    [coder encodeObject:_user_name forKey:@"_user_name"];
    [coder encodeObject:_image forKey:@"_image"];
    [coder encodeObject:_phone_number forKey:@"_phone_number"];
    
    [coder encodeObject:_regist_date forKey:@"_regist_date"];
    [coder encodeObject:_user_state_now forKey:@"_user_state_now"];
    [coder encodeObject:_password forKey:@"_password"];
    [coder encodeObject:_nick_name forKey:@"_nick_name"];
    [coder encodeObject:_auth_key forKey:@"_auth_key"];
    [coder encodeObject:_home_address forKey:@"_home_address"];
    [coder encodeObject:_qr_image forKey:@"_qr_image"];
    [coder encodeObject:_docInfoDtoList forKey:@"_docInfoDtoList"];
    
    [coder encodeObject:_province_id forKey:@"_province_id"];
    [coder encodeObject:_city_id forKey:@"_city_id"];
    [coder encodeObject:_district_id forKey:@"_district_id"];
    [coder encodeObject:_town_id forKey:@"_town_id"];
    [coder encodeObject:_community_id forKey:@"_community_id"];
    
    [coder encodeObject:_province_name forKey:@"_province_name"];
    [coder encodeObject:_city_name forKey:@"_city_name"];
    [coder encodeObject:_district_name forKey:@"_district_name"];
    [coder encodeObject:_town_name forKey:@"_town_name"];
    [coder encodeObject:_community_name forKey:@"_community_name"];
    
}

#pragma mark - save / read
// 归档
- (void)saveToFile {
    [NSKeyedArchiver archiveRootObject:self toFile:[JKDirectoryManager loginInfoFilePath]];
}

// 解档
+ (NewUser *)readFromFile {
    NewUser *model = [NSKeyedUnarchiver unarchiveObjectWithFile:[JKDirectoryManager loginInfoFilePath]];
    return model;
}

// 删档
+ (void)removeFile {
    [JKDirectoryManager removeDirectory:[JKDirectoryManager loginInfoFilePath]];
}


@end
