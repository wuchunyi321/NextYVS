//
//  BRTool.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/13.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRTool : NSObject

////测试(1,是过审，2，是正常)
//+ (NSInteger)test;

+ (id)paserDictionary:(NSDictionary*)dic forKey:(id)key;

+ (id)paserValue:(id)value;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

#pragma mark - permission check  // 相册（读和写） 摄像头 麦克风
+(BOOL)permissionAboutPhoto;
+(BOOL)permissionAboutCamera;
+(BOOL)permissionAboutMicrophone;

#pragma mark --- 天前
+ (NSString *)timeStringFromDataToNow:(NSString *)compareDateInString;

#pragma mark -- 工具
+ (NSString *)getTheBackStrWithgrade:(NSInteger)grade;





@end

NS_ASSUME_NONNULL_END
