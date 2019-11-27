//
//  MinePayModel.h
//  BRCJ
//
//  Created by wuchunyi on 2019/11/26.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 {
     buyerPayPrice = "<null>";
     currentLevel = 1;
     id = 37fb58ffe1a1433f8afb68968735bb65;
     orderDate = "2019-11-22 15:39:11";
     orderStatus = 0;
     outTradeNo = 20191122153911127929;
     payChannel = 20;
     payDate = "<null>";
     receiptPrice = "<null>";
     rechargeLevel = "GOLD_MEMBER";
     refundId = "<null>";
     subject = "\U8ba2\U5355\U5145\U503c";
     totalPrice = 158000;
     tradeNo = "<null>";
     updateTime = "2019-11-22 15:39:11";
     userId = 13579122;
 }
 */



@interface MinePayModel : NSObject

@property (nonatomic,copy)NSString *buyerPayPrice;
@property (nonatomic,copy)NSString *currentLevel;
@property (nonatomic,copy)NSString *p_id;
@property (nonatomic,copy)NSString *orderDate;
@property (nonatomic,copy)NSString *orderStatus;
@property (nonatomic,copy)NSString *outTradeNo;
@property (nonatomic,copy)NSString *payChannel;
@property (nonatomic,copy)NSString *payDate;
@property (nonatomic,copy)NSString *receiptPrice;
@property (nonatomic,copy)NSString *rechargeLevel;
@property (nonatomic,copy)NSString *refundId;
@property (nonatomic,copy)NSString *subject;
@property (nonatomic,copy)NSString *totalPrice;
@property (nonatomic,copy)NSString *tradeNo;
@property (nonatomic,copy)NSString *updateTime;
@property (nonatomic,copy)NSString *userId;


@end

NS_ASSUME_NONNULL_END
