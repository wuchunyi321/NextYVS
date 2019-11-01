//
//  BankCardModel.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/20.
//  Copyright © 2019 cy. All rights reserved.
//

#import "BankCardModel.h"

@implementation BankCardModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"card_id" :  @"id"
             };
}

@end
