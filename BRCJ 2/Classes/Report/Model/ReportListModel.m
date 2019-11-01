//
//  ReportListModel.m
//  BRCJ
//
//  Created by wuchunyi on 2019/9/11.
//  Copyright © 2019 cy. All rights reserved.
//

#import "ReportListModel.h"

@implementation ReportListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"r_id" :  @"id"
             };
}

@end
