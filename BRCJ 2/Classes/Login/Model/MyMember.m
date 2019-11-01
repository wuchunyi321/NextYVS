//
//  MyMember.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/13.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MyMember.h"

#import "JKDirectoryManager.h"

@implementation MyMember

#pragma mark - encode / decode
// encode
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_userId forKey:@"userId"];
    [aCoder encodeObject:_vipLevel forKey:@"vipLevel"];
    [aCoder encodeObject:_vipLevelName forKey:@"vipLevelName"];
    [aCoder encodeObject:_addTime forKey:@"addTime"];
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
    [aCoder encodeObject:_mid forKey:@"mid"];
}

// decode
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.vipLevel = [aDecoder decodeObjectForKey:@"vipLevel"];
        self.vipLevelName = [aDecoder decodeObjectForKey:@"vipLevelName"];
        self.addTime = [aDecoder decodeObjectForKey:@"addTime"];
        self.updateTime = [aDecoder decodeObjectForKey:@"updateTime"];
        self.mid = [aDecoder decodeObjectForKey:@"mid"];
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
    NSLog(@"the error == %@",error);
    [data writeToFile:[JKDirectoryManager memberInfoFilePath] atomically:YES];
}

// 解档
+ (MyMember *)readFromFile {
    NSError *error;
    NSData *data = [[NSData alloc] initWithContentsOfFile:[JKDirectoryManager memberInfoFilePath]];
    //会调用对象的initWithCoder方法
    MyMember *content = [NSKeyedUnarchiver unarchivedObjectOfClass:[MyMember class] fromData:data error:&error];
    if (error) {
        return nil;
    }
    return content;
}

// 删档
+ (void)removeFile {
    [JKDirectoryManager removeDirectory:[JKDirectoryManager memberInfoFilePath]];
}


@end
