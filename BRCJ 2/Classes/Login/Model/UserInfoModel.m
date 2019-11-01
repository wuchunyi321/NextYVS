//
//  UserInfoModel.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import "UserInfoModel.h"
#import "JKDirectoryManager.h"

#define TestPhoneNumber (@"18514528955")


@implementation UserInfoModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"user_id" :  @"id"
             };
}

#pragma mark - encode / decode

// encode
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.user_id forKey:@"user_id"];
    [aCoder encodeObject:self.account forKey:@"account"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.passwd forKey:@"passwd"];
    [aCoder encodeObject:self.role forKey:@"role"];
    [aCoder encodeObject:self.createUser forKey:@"createUser"];
    [aCoder encodeObject:self.addTime forKey:@"addTime"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.delFlag forKey:@"delFlag"];
    [aCoder encodeObject:self.note forKey:@"note"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.headPortrait forKey:@"headPortrait"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.country forKey:@"country"];
    [aCoder encodeObject:self.inviteCode forKey:@"inviteCode"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.lastLoginTime forKey:@"lastLoginTime"];
    [aCoder encodeObject:self.loginCount forKey:@"loginCount"];
    [aCoder encodeObject:self.genTime forKey:@"genTime"];
    [aCoder encodeObject:self.updateTime forKey:@"updateTime"];
}

// decode
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.user_id = [aDecoder decodeObjectForKey:@"user_id"];
        self.account = [aDecoder decodeObjectForKey:@"account"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.passwd = [aDecoder decodeObjectForKey:@"passwd"];
        self.role = [aDecoder decodeObjectForKey:@"role"];
        self.createUser = [aDecoder decodeObjectForKey:@"createUser"];
        self.addTime = [aDecoder decodeObjectForKey:@"addTime"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.delFlag = [aDecoder decodeObjectForKey:@"delFlag"];
        self.note = [aDecoder decodeObjectForKey:@"note"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.headPortrait = [aDecoder decodeObjectForKey:@"headPortrait"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.province = [aDecoder decodeObjectForKey:@"province"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.country = [aDecoder decodeObjectForKey:@"country"];
        self.inviteCode = [aDecoder decodeObjectForKey:@"inviteCode"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.lastLoginTime = [aDecoder decodeObjectForKey:@"lastLoginTime"];
        self.loginCount = [aDecoder decodeObjectForKey:@"loginCount"];
        self.genTime = [aDecoder decodeObjectForKey:@"genTime"];
        self.updateTime = [aDecoder decodeObjectForKey:@"updateTime"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

#pragma mark - save / read
// 归档
- (void)saveToFile {
    NSError *error;
    //会调用对象的encodeWithCoder方法
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self
                                         requiringSecureCoding:YES
                                                         error:&error];
    [data writeToFile:[JKDirectoryManager loginInfoFilePath] atomically:YES];
}

// 解档
+ (UserInfoModel *)readFromFile {
    NSError *error;
    NSData *data = [[NSData alloc] initWithContentsOfFile:[JKDirectoryManager loginInfoFilePath]];
    //会调用对象的initWithCoder方法
    UserInfoModel *content = [NSKeyedUnarchiver unarchivedObjectOfClass:[UserInfoModel class] fromData:data error:&error];
    if (error) {
        return nil;
    }
    return content;
}

// 删档
+ (void)removeFile {
    [JKDirectoryManager removeDirectory:[JKDirectoryManager loginInfoFilePath]];
}

@end
