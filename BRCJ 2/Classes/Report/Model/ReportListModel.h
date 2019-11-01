//
//  ReportListModel.h
//  BRCJ
//
//  Created by wuchunyi on 2019/9/11.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 {
                 addTime = "2019-08-29 17:15:20";
                 cause = "<null>";
                 clicks = 0;
                 delFlag = 0;
                 grade = 1;
                 id = 59643b86a14e440eacff5ba5ad3991a8;
                 rrContent = "<null>";
                 rrHtml = 10;
                 rrIntroduction = "<null>";
                 rrName = 11111111111;
                 rrPic = "<null>";
                 securitiesPersonnel = 088;
                 sid = rrrrrrrrrrrr;
                 status = 3;
                 updateTime = "2019-08-29 17:15:20";
                 userId = 13579109;
             }
 
 {
 addTime = "2019-09-30 16:55:50";
 cause = "";
 clicks = 0;
 delFlag = 0;
 grade = 1;
 id = b64660385f194b3a8b966b3c97d80a15;
 rrName = "2019\U6700\U5f3a\U6295\U8d44\U4e3b\U7ebf:\U201c\U65b0\U57fa\U5efa\U201d\U5404\U7ec6\U5206\U9886\U57df\U5168\U68b3\U7406 ";
 rrPic = "<null>";
 securitiesPersonnel = "\U674e\U60a6";
 sid = 826b0199ec944426b9b68112175feaa1;
 sort = "<null>";
 status = 3;
 updateTime = "2019-10-02 14:18:26";
 userId = 13579131;
 }
 )
 
 
 **/


NS_ASSUME_NONNULL_BEGIN

@interface ReportListModel : NSObject

@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *cause;
@property(nonatomic,copy)NSString *clicks;
@property(nonatomic,copy)NSString *delFlag;
@property(nonatomic,copy)NSString *grade;
@property(nonatomic,copy)NSString *r_id;
@property(nonatomic,copy)NSString *rrContent;
@property(nonatomic,copy)NSString *rrHtml;
@property(nonatomic,copy)NSString *rrIntroduction;
@property(nonatomic,copy)NSString *rrName;
@property(nonatomic,copy)NSString *rrPic;
@property(nonatomic,copy)NSString *securitiesCode;
@property(nonatomic,copy)NSString *sid;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *updateTime;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *sort;

@end

NS_ASSUME_NONNULL_END
