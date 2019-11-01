//
//  AcountModel.m
//  BRCJ
//
//  Created by wuchunyi on 2019/10/21.
//  Copyright © 2019 cy. All rights reserved.
//

#import "AcountModel.h"

#import "JKDirectoryManager.h"

@implementation AcountModel

#pragma mark - encode / decode
// encode
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_account forKey:@"account"];
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_type forKey:@"type"];
}

// decode
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.account = [aDecoder decodeObjectForKey:@"account"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
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
    [data writeToFile:[JKDirectoryManager accountInfoFilePath] atomically:YES];
}

// 解档
+ (AcountModel *)readFromFile {
    NSError *error;
    NSData *data = [[NSData alloc] initWithContentsOfFile:[JKDirectoryManager accountInfoFilePath]];
    //会调用对象的initWithCoder方法
    AcountModel *content = [NSKeyedUnarchiver unarchivedObjectOfClass:[AcountModel class] fromData:data error:&error];
    if (error) {
        return nil;
    }
    return content;
}

// 删档
+ (void)removeFile {
    [JKDirectoryManager removeDirectory:[JKDirectoryManager accountInfoFilePath]];
}

@end
