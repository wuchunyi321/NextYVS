
//
//  JKDirectoryManager.m
//  Doctor
//
//  Created by joy’s mac  on 2018/3/12.
//  Copyright © 2018年 cy. All rights reserved.
//

#import "JKDirectoryManager.h"

//NSString * const kWavRecordFileName = @"RecordFile.wav";


@implementation JKDirectoryManager


// 获取documents目录
+ (NSString *)documentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return paths[0];
}

// 获取temp目录
+ (NSString *)tempPath {
    
    return NSTemporaryDirectory ();
}

// 获取缓存目录，不存在则创建
+ (NSString *)localCachePath{
    NSString *docPath = [self.class documentsPath];
    NSString *cachePath = [docPath stringByAppendingPathComponent:@"LocalCacheFiles"];
    [self.class createDirectory:cachePath];
    
    return cachePath;
}

// 创建目录
+ (BOOL)createDirectory:(NSString *)directory
{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    // 不存在才创建
    if (![fm fileExistsAtPath:directory]){
        
        return [fm createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return YES;
}


// 删除目录
+ (BOOL)removeDirectory:(NSString *)directory{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:directory]){
        
        return [fm removeItemAtPath:directory error:nil];
    }
    
    return YES;
}




// 登录信息文件路径
+ (NSString *)loginInfoFilePath {
    return [[self.class documentsPath] stringByAppendingPathComponent:@"InnerLoginInfo"];
}

// 用户信息文件路径
+ (NSString *)memberInfoFilePath {
    return [[self.class documentsPath] stringByAppendingPathComponent:@"InnerMemberInfo"];
}

// 其他信息文件路径
+ (NSString *)accountInfoFilePath {
    return [[self.class documentsPath] stringByAppendingPathComponent:@"InnerAccountInfo"];
}

// 录音缓存的文件目录(wav)
+ (NSString *)wavRecordFilePathWithUrl:(NSString *)url{
    return [[self.class tempPath] stringByAppendingPathComponent:url];
}

+(void)removeAllTempFiles{
    NSArray *subPathArr = [[NSFileManager defaultManager] subpathsAtPath:[self.class tempPath]];
    NSLog(@"===== all files %@",subPathArr);
    for (NSString *str in subPathArr) {
        [self.class removeDirectory:[self.class wavRecordFilePathWithUrl:str]];
    }
}



@end
