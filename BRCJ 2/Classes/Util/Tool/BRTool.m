//
//  BRTool.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/13.
//  Copyright © 2019 cy. All rights reserved.
//

#import "BRTool.h"

#import<Photos/Photos.h>
#import <AVFoundation/AVCaptureDevice.h>


@implementation BRTool

////测试(1,是过审，2，是正常)
//+ (NSInteger)test{
//    return 2;
//}

+ (id)paserDictionary:(NSDictionary*)dic forKey:(id)key
{
    id value = [dic objectForKey:key];
    if ([value isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return value;
}

+ (id)paserValue:(id)value
{
    if ([value isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return value;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


#pragma mark - permission check  // 相册（读和写） 摄像头 麦克风
+(BOOL)permissionAboutPhoto{
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    //无权限
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        
        [[[UIAlertView alloc]initWithTitle:@"温馨提示"
                                   message:@"请在iPhone的 设置 - 隐私 - 照片 选项中,允许应用访问您的照片"
                                  delegate:self
                         cancelButtonTitle:nil
                         otherButtonTitles:@"好的", nil]
         show];
        return NO;
    }
    
    return YES;
}

+(BOOL)permissionAboutCamera{
    
    AVAuthorizationStatus authStatus =[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    //无权限
    if (authStatus == AVAuthorizationStatusRestricted ||
        authStatus ==AVAuthorizationStatusDenied){
        
        [[[UIAlertView alloc]initWithTitle:@"温馨提示"
                                   message:@"请在iPhone的 设置 - 隐私 - 相机 选项中,允许应用访问您的相机"
                                  delegate:self
                         cancelButtonTitle:nil
                         otherButtonTitles:@"好的", nil]
         show];
        return NO;
    }
    
    return YES;
}

+(BOOL)permissionAboutMicrophone{
    
    AVAuthorizationStatus authStatus =[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    //无权限
    if (authStatus == AVAuthorizationStatusRestricted ||
        authStatus ==AVAuthorizationStatusDenied){
        [[[UIAlertView alloc]initWithTitle:@"温馨提示"
                                   message:@"请在iPhone的 设置 - 隐私 - 麦克风 选项中,允许应用访问您的麦克风"
                                  delegate:self
                         cancelButtonTitle:nil
                         otherButtonTitles:@"好的", nil]
         show];
        return NO;
    }
    
    return YES;
}

+(NSString *)timeStringFromDataToNow:(NSString *)compareDateInString
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFromServer = [inputFormatter dateFromString:compareDateInString];
    
    NSDate *now = [NSDate date];
    NSTimeInterval daysInterValBySeconds = [now timeIntervalSinceDate: dateFromServer];
    int days = ((int)daysInterValBySeconds/(3600*24));
    int hours = ((int)daysInterValBySeconds)%(3600*24)/3600;
    int minutes = ((int)daysInterValBySeconds)%3600/60;
    
    if (days>0)
    {
        return [NSString stringWithFormat:@"%d天前",days];
    }
    else if (hours>0)
    {
        return [NSString stringWithFormat:@"%d小时前",hours];
    }
    else if (minutes>0)
    {
        return [NSString stringWithFormat:@"%d分钟前",minutes];
    }
    else
    {
        return [NSString stringWithFormat:@"%d秒前",((int)daysInterValBySeconds)%60];
    }
    return @"";
}

#pragma mark -- 工具
+ (NSString *)getTheBackStrWithgrade:(NSInteger)grade{
    NSString *backStr = @"散户";
    if (grade == 1) {
        backStr = @"散户";
    }else if (grade == 2){
        backStr = @"百万";
    }else if (grade == 3){
        backStr = @"千万";
    }else if(grade == 4){
        backStr = @"亿万";
    }else{
        backStr = @"无";
    }
    return backStr;
}

/**
  根据等级gradeStr值确定等级Str
 */
+ (NSString *)getTheBackStrWithgradeStr:(NSString *)gradeStr isBackInt:(BOOL)backInt{
    NSString *backStr = backInt?@"1":@"散户俱乐部";
    if ([gradeStr isEqualToString:@"COPPER_CARD_MEMBER"]) {
        backStr = backInt?@"1":@"散户俱乐部";
    }else if ([gradeStr isEqualToString:@"SILVER_MEMBER"]){
        backStr = backInt?@"2":@"百万俱乐部";
    }else if ([gradeStr isEqualToString:@"GOLD_MEMBER"]){
        backStr = backInt?@"3":@"千万俱乐部";
    }else if([gradeStr isEqualToString:@"PLATINUM_MEMBER"]){
        backStr = backInt?@"4":@"亿万俱乐部";
    }else{
        backStr = @"0";
    }
    return backStr;
}


+ (NSString *)getTheGradeStrWith:(NSInteger)grade{
    NSString *backStr = @"COPPER_CARD_MEMBER";
    if (grade == 1) {
        backStr = @"COPPER_CARD_MEMBER";
    }else if (grade == 2){
        backStr = @"SILVER_MEMBER";
    }else if (grade == 3){
        backStr = @"GOLD_MEMBER";
    }else if(grade == 4){
        backStr = @"PLATINUM_MEMBER";
    }
    return backStr;
}

+ (NSInteger )getThePriceStrWith:(NSInteger)grade{
    NSInteger backStr = 0;
    switch (grade) {
        case 1:
        {
            backStr = COPPER_CARD_MEMBER_PRICE;
        }
            break;
        case 2:
        {
            backStr = SILVER_MEMBER_PRICE;
        }
            break;
        case 3:
        {
            backStr = GOLD_MEMBER_PRICE;
        }
            break;
        case 4:
        {
            backStr = PLATINUM_MEMBER_PRICE;
        }
            break;
        default:
            break;
    }
    return backStr;
}

@end
