//
//  JKDirectoryManager.h
//  Doctor
//
//  Created by joy’s mac  on 2018/3/12.
//  Copyright © 2018年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKDirectoryManager : NSObject

// 获取documents目录
+ (NSString *)documentsPath;

// 获取temp目录
+ (NSString *)tempPath;

// 获取缓存目录，不存在则创建
+ (NSString *)localCachePath;

// 创建目录
+ (BOOL)createDirectory:(NSString *)directory;

// 删除目录
+ (BOOL)removeDirectory:(NSString *)directory;


// 登录信息文件路径
+ (NSString *)loginInfoFilePath;

// 医生信息文件路径
+ (NSString *)memberInfoFilePath;

// 其他信息文件路径
+ (NSString *)accountInfoFilePath;

// 录音缓存的文件目录(wav)
+ (NSString *)wavRecordFilePathWithUrl:(NSString *)url;
+(void)removeAllTempFiles;


@end
