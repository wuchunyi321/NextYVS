//
//  UserContext.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/29.
//  Copyright © 2019 cy. All rights reserved.
//

#import "UserContext.h"

/** 清空用户信息用 **/
#import "UserInfoModel.h"
#import "MyMember.h"
#import "AcountModel.h"
@class NewUser;

@implementation UserContext


+ (CGFloat) getTheHeightOfStr:(NSString *)str withWidth:(CGFloat)width AndFont:(CGFloat)font{
    CGFloat sizeHeight = [str boundingRectWithSize:CGSizeMake(width, 1000)
                                           options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                           context:nil].size.height+15;
    return sizeHeight;
}

+ (NSString *)ddpGetExpectTimestamp:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    
    ///< 当前时间
    NSDate *currentdata = [NSDate date];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSDateComponents *datecomps = [[NSDateComponents alloc] init];
    [datecomps setYear:year?(-year):0];
    [datecomps setMonth:month?(-month):0];
    [datecomps setDay:day?(-day):0];
    
    ///< dateByAddingComponents: 在参数date基础上，增加一个NSDateComponents类型的时间增量
    NSDate *calculatedate = [calendar dateByAddingComponents:datecomps toDate:currentdata options:0];
    
    ///< 打印推算时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *calculateStr = [formatter stringFromDate:calculatedate];
    ///< 预期的推算时间
    NSLog(@"calculateStr 推算时间: %@",calculateStr );
    NSString *result = [NSString stringWithFormat:@"%ld", (long)[calculatedate timeIntervalSince1970]];
    return result;
}

+ (BOOL)ischeckPhoneNumber:(NSString *)number{
    if([number isEqualToString:@""]){
        return NO;
    }else{
        for (int i=0; i<[number length]; i++) {
            char c=[number characterAtIndex:i];
            //检查是不是其他不合法字符
            if ((c>57||c<48)&&(c!=43)) {
                return NO;
            }
        }
    }
    
    NSString *fir=[number substringToIndex:1];
    if([fir isEqualToString:@"1"]&&number.length==11){
        return YES;
    }else if([fir isEqualToString:@"0"]&&(number.length>=11&&number.length<=20)){
        return YES;
    }else if([fir isEqualToString:@"+"]&&(number.length>=14&&number.length<=20)){
        return YES;
    }
    return NO;
}

+ (UIFont *)getTheFontWithName:(NSString *)fontName size:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:fontName size:size];
    return font;
}

//token
+(void)setAccessToken:(NSString *)token{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:token forKey:@"innerToken"];
    [ud synchronize];
}

+(NSString *)getAccessToken{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:@"innerToken"];
    return token;
}

//TestUID
+ (void)setUID:(NSNumber *)UID{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:UID forKey:@"UID"];
    [ud synchronize];
}
+ (NSNumber *)getUID{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSNumber *token = [ud objectForKey:@"UID"];
    return token;
}

//基本信息
+ (void)setUserInfo:(NewUser *)model{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:model];
    [ud setObject:udObject forKey:@"UserInfo"];
    [ud synchronize];
}

+ (NewUser *)getUserInfo{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *udObject = [ud objectForKey:@"UserInfo"];
    NewUser *thisUserInfo = [NSKeyedUnarchiver unarchiveObjectWithData:udObject];
    return thisUserInfo;
}

/** 判断登录状态+ 清空登录状态 **/
+ (BOOL)isLogin{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefault objectForKey:@"innerToken"];
    if (token && token.length > 0) {
        return YES;
    }
    return NO;
}

+ (void)clearLogin{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"" forKey:@"innerToken"];
    [UserInfoModel removeFile];
    [MyMember removeFile];
    [AcountModel removeFile];
}

@end
