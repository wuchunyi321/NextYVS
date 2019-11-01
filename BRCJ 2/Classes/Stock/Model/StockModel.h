//
//  StockModel.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/22.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StockModel : NSObject

@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *anchorId;
@property(nonatomic,copy)NSString *classify;
@property(nonatomic,copy)NSString *delFlag;
@property(nonatomic,copy)NSString *stock_id;
@property(nonatomic,copy)NSString *introduction;
@property(nonatomic,copy)NSString *shareTitle;
@property(nonatomic,copy)NSString *shareType;
@property(nonatomic,copy)NSString *clicks;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *thumbnail;
@property(nonatomic,copy)NSString *updateTime;
@property(nonatomic,copy)NSString *videoUrl;
@property(nonatomic,copy)NSString *grade;

@end

NS_ASSUME_NONNULL_END
