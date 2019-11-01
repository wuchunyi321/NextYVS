//
//  ReportPersonModel.m
//  BRCJ
//
//  Created by wuchunyi on 2019/9/11.
//  Copyright © 2019 cy. All rights reserved.
//

#import "ReportPersonModel.h"

@implementation ReportPersonModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"r_id" :  @"id"
             };
}

@end
