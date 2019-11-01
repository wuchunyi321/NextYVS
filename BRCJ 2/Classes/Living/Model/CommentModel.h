//
//  CommentModel.h
//  BRCJ
//
//  Created by wuchunyi on 2019/9/19.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 {
 "userId" : 13579108,
 "content" : "test",
 "delFlag" : "0",
 "id" : "f80f5a134ce04273b3b0af0c0db3bb8a",
 "materialId" : "1234ert",
 "pic" : null,
 "updateTime" : "2019-09-19 14:55:22",
 "nickname" : null,
 "addTime" : "2019-09-19 14:55:22",
 "headPortrait" : null
 }
 **/


NS_ASSUME_NONNULL_BEGIN

@interface CommentModel : NSObject

@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *delFlag;
@property(nonatomic,copy)NSString *c_id;
@property(nonatomic,copy)NSString *materialId;
@property(nonatomic,copy)NSString *pic;
@property(nonatomic,copy)NSString *updateTime;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *headPortrait;

@end

NS_ASSUME_NONNULL_END
