//
//  StockModel.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/22.
//  Copyright © 2019 cy. All rights reserved.
//

#import "StockModel.h"

@implementation StockModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"stock_id" :  @"id"
             };
}

@end
