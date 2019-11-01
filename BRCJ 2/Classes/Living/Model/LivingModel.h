//
//  LivingModel.h
//  BRCJ
//
//  Created by wuchunyi on 2019/9/18.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 {
             addTime = "<null>";
             anchorId = 4;
             delFlag = 0;
             grade = 2;
             id = 4234nnmk;
             introduction = 4;
             sort = "<null>";
             thumbnail = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566300473372&di=8689c90d3756be00368851d129de45cc&imgtype=0&src=http%3A%2F%2Fs2.sinaimg.cn%2Fmw690%2F006aZ2sKzy6XZuayR4l71";
             updateTime = "<null>";
             userId = 4;
             videoTitle = 4;
             videoType = 4;
             videoUrl = "https://black-horse-club.oss-cn-hangzhou.aliyuncs.com/demo/1567851279814-90812f46-d589-4635.mp4";
         }
 */



@interface LivingModel : NSObject

@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *anchorId;
@property(nonatomic,copy)NSString *delFlag;
@property(nonatomic,copy)NSString *grade;
@property(nonatomic,copy)NSString *l_id;
@property(nonatomic,copy)NSString *introduction;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *thumbnail;
@property(nonatomic,copy)NSString *updateTime;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *videoTitle;
@property(nonatomic,copy)NSString *videoType;
@property(nonatomic,copy)NSString *videoUrl;


@end

NS_ASSUME_NONNULL_END
