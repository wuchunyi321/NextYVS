//
//  BannerModel.h
//  BRCJ
//
//  Created by wuchunyi on 2019/10/15.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 {
     "id": "2906e556739a49a98d37e01eb2dc575e",
     "jumpAddress": null,
     "thumbnail": "https://black-horse-club.oss-cn-hangzhou.aliyuncs.com/banner/1571034394829-fa7e1fdf-860e-4541.png",
     "introduction": null,
     "addTime": "2019-10-14 10:22:04",
     "updateTime": "2019-10-14 16:22:07",
     "type": "2",
     "classification": "mobile"
 }
 */


@interface BannerModel : NSObject

@property(nonatomic,copy)NSString *b_id;
@property(nonatomic,copy)NSString *jumpAddress;
@property(nonatomic,copy)NSString *thumbnail;
@property(nonatomic,copy)NSString *introduction;
@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *updateTime;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *classification;

@end

NS_ASSUME_NONNULL_END
