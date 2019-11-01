//
//  BankCardModel.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/20.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankCardModel : NSObject


@property(nonatomic,copy)NSString *cardOwner;
@property(nonatomic,copy)NSString *bankName;
@property(nonatomic,copy)NSString *bankCardNumber;
@property(nonatomic,copy)NSString *card_id;
@property(nonatomic,copy)NSString *updateTime;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *isDefault;
@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *deleteFlag;
@property(nonatomic,copy)NSString *reservePhone;

@end

NS_ASSUME_NONNULL_END
