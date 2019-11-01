//
//  CommentModel.m
//  BRCJ
//
//  Created by wuchunyi on 2019/9/19.
//  Copyright © 2019 cy. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"c_id" :  @"id"
             };
}

@end
