//
//  UserFinanceModel.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/20.
//  Copyright © 2019 cy. All rights reserved.
//

#import "UserFinanceModel.h"

@implementation UserFinanceModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"finance_id" :  @"id"
             };
}

@end
