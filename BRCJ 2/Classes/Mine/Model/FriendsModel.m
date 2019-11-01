//
//  FriendsModel.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/21.
//  Copyright © 2019 cy. All rights reserved.
//

#import "FriendsModel.h"

@implementation FriendsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"friendId" :  @"id"
             };
}

@end
