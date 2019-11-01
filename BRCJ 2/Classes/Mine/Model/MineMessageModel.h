//
//  MineMessageModel.h
//  BRCJ
//
//  Created by wuchunyi on 2019/10/9.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineMessageModel : NSObject

@property (nonatomic,copy)NSString *userId;

@property (nonatomic,copy)NSString *deviceId;
@property (nonatomic,copy)NSString *isRead;
@property (nonatomic,copy)NSString *updateTime;
@property (nonatomic,copy)NSString *mid;
@property (nonatomic,copy)NSString *message;
@property (nonatomic,copy)NSString *addTime;

@end

NS_ASSUME_NONNULL_END
