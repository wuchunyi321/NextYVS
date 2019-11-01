//
//  SchoolListItem.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/16.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 {
 "id" : "becde081fec14971baab1a49cb2aac24",
 "videoUrl" : "https:\/\/black-horse-club.oss-cn-hangzhou.aliyuncs.com\/school\/1569568045413-27c90a7b-ee63-43fd.mp4",
 "videoTitle" : "趋势线战法2",
 "delFlag" : "0",
 "introduction" : "趋势线战法详解2",
 "videoType" : "1",
 "userId" : 13579120,
 "addTime" : "2019-09-27 15:13:28",
 "clicks" : "0",
 "anchorId" : "32deidkdkd",
 "thumbnail" : "https:\/\/black-horse-club.oss-cn-hangzhou.aliyuncs.com\/school\/1569567981177-0beb8b33-95bc-4c4c.png",
 "sort" : 999999,
 "grade" : "0",
 "updateTime" : "2019-09-27 15:13:28"
 },
 **/

@interface SchoolListItem : NSObject

@property(nonatomic,copy)NSString *item_id;
@property(nonatomic,copy)NSString *videoUrl;
@property(nonatomic,copy)NSString *videoTitle;
@property(nonatomic,copy)NSString *delFlag;
@property(nonatomic,copy)NSString *introduction;
@property(nonatomic,copy)NSString *videoType;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *clicks;
@property(nonatomic,copy)NSString *anchorId;
@property(nonatomic,copy)NSString *thumbnail;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *grade;
@property(nonatomic,copy)NSString *updateTime;

@end

NS_ASSUME_NONNULL_END
