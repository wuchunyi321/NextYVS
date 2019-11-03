//
//  AFHTTPSessionManager+AddMethod.h
//  BRCJ
//
//  Created by wuchunyi on 2019/11/2.
//  Copyright © 2019 cy. All rights reserved.
//


#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTPSessionManager (AddMethod)
/** 吴春艺加上 **/
- (nullable NSURLSessionDataTask *)NewPOST:(NSString *)URLString
                                parameters:(nullable id)parameters
                                  progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                   success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                   failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error,id _Nullable responseObject))failure;


@end

NS_ASSUME_NONNULL_END
