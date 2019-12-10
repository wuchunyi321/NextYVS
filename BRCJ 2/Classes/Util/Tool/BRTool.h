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

/**
 根据等级grade值确定等级Str
 */
+ (NSString *)getTheBackStrWithgrade:(NSInteger)grade;
/**
  根据等级gradeStr值确定等级Str
 */
+ (NSString *)getTheBackStrWithgradeStr:(NSString *)gradeStr isBackInt:(BOOL)backInt;
/**
 充值前，设置参数
 */
+ (NSString *)getTheGradeStrWith:(NSInteger)grade;
/**
 根据需要充值的等级，判断需要充值多少钱
 */
+ (NSInteger )getThePriceStrWith:(NSInteger)grade;


@end

NS_ASSUME_NONNULL_END
