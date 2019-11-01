//
//  JKModelConvert.h
//  Doctor
//
//  Created by joy’s mac  on 2018/3/9.
//  Copyright © 2018年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKModelConvert : NSObject


/**
 * 统一的转化方法(按字典、数组分别转化)
 * @param     modelClass --- 数据模型类名
 * @param responseObject --- response数据（字典或数组）
 */
+ (id)dataModelWithClass:(Class)modelClass andSource:(id)responseObject;

@end
