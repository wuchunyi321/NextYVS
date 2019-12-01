//
//  JKModelConvert.m
//  Doctor
//
//  Created by joy’s mac  on 2018/3/9.
//  Copyright © 2018年 cy. All rights reserved.
//

#import "JKModelConvert.h"
#import "MJExtension.h"

@implementation JKModelConvert

+ (id)dataModelWithClass:(Class)modelClass andSource:(id)responseObject
{
    // 字典
    if ([responseObject isKindOfClass:[NSDictionary class]])
    {
        return [modelClass mj_objectWithKeyValues:responseObject];
    }
    // 数组
    else if ([responseObject isKindOfClass:[NSArray class]])
    {
        return [modelClass mj_objectArrayWithKeyValuesArray:responseObject];
    }
    
    // 默认返回nil
    return nil;
}


@end
