//
//  SecuritiesCompanyModel.m
//  BRCJ
//
//  Created by wuchunyi on 2019/10/15.
//  Copyright © 2019 cy. All rights reserved.
//

#import "SecuritiesCompanyModel.h"

@implementation SecuritiesCompanyModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"s_id" :  @"id"
             };
}

@end
