//
//  ReportPersonModel.h
//  BRCJ
//
//  Created by wuchunyi on 2019/9/11.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 {
   "id" : "fc59da561892491ea986e84fbf83bcd8",
   "updateTime" : "2019-09-25 16:26:17",
   "delFlag" : "0",
   "securitiesCode" : "899950406758839",
   "sex" : "1",
   "oneIntroduction" : "初来匝道，多多关照",
   "introduction" : "炒股不识李大霄，抄底总在半山腰。\n若想炒股不被套，大霄呐喊咱就跑",
   "heat" : "1",
   "securitiesCodeSecond" : null,
   "securitiesCodeThree" : null,
   "userId" : 13579122,
   "idCard" : "674748494949",
   "addTime" : "2019-09-25 15:38:49",
   "cause" : null,
   "headPortrait" : null,
   "status" : "3",
   "name" : "吴春"
 }
 */

@interface ReportPersonModel : NSObject

@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *cause;
@property(nonatomic,copy)NSString *delFlag;
@property(nonatomic,copy)NSString *heat;
@property(nonatomic,copy)NSString *r_id;
@property(nonatomic,copy)NSString *idCard;
@property(nonatomic,copy)NSString *introduction;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *oneIntroduction;
@property(nonatomic,copy)NSString *securitiesCode;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *updateTime;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *headPortrait;

@property(nonatomic,copy)NSString *securitiesCodeSecond;
@property(nonatomic,copy)NSString *securitiesCodeThree;

@end

NS_ASSUME_NONNULL_END
