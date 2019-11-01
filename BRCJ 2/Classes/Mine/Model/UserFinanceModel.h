//
//  UserFinanceModel.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/20.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserFinanceModel : NSObject

@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *delFlag;
@property(nonatomic,copy)NSString *finance_id;
@property(nonatomic,copy)NSString *updateTime;
@property(nonatomic,copy)NSString *totalRecharge;
@property(nonatomic,copy)NSString *totalBuyback;
@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *totalUse;


@end

NS_ASSUME_NONNULL_END
