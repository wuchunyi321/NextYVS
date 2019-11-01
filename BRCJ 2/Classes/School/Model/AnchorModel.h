//
//  AnchorModel.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/19.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 {
     addTime = "<null>";
     anchorIntroduction = "\U5b87\U5b99\U77ed\U7ebf\U4e00\U54e5";
     anchorLabel = "\U820d\U6211\U5176\U8c01";
     anchorName = "\U77ed\U7ebf\U738b\U8005";
     delFlag = 0;
     fansNumber = 4;
     headPortrait = "https://black-horse-club.oss-cn-hangzhou.aliyuncs.com/head-portrait/1569481235386-dc261435-6b71-4cc4.jpeg";
     heat = 1111111111;
     id = 32deidkdkd;
     idCard = 111111111112222222222;
     securitiesCode = "\U5206\U6790\U5e08\Uff1aooooooooooooo99999999999";
     securitiesCodeSecond = 43434eeeerfff;
     securitiesCodeThree = edf33fdfd;
     sex = 1;
     updateTime = "2019-10-19 16:28:09";
     userId = 13579120;
 }
 */



@interface AnchorModel : NSObject

@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *anchorIntroduction;
@property(nonatomic,copy)NSString *anchorLabel;
@property(nonatomic,copy)NSString *anchorName;
@property(nonatomic,copy)NSString *delFlag;
@property(nonatomic,copy)NSString *fansNumber;
@property(nonatomic,copy)NSString *headPortrait;
@property(nonatomic,copy)NSString *heat;
@property(nonatomic,copy)NSString *a_id;
@property(nonatomic,copy)NSString *idCard;
@property(nonatomic,copy)NSString *securitiesCode;
@property(nonatomic,copy)NSString *securitiesCodeSecond;
@property(nonatomic,copy)NSString *securitiesCodeThree;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *updateTime;
@property(nonatomic,copy)NSString *userId;

@end

NS_ASSUME_NONNULL_END
