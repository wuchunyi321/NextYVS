//
//  AcountModel.h
//  BRCJ
//
//  Created by wuchunyi on 2019/10/21.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AcountModel : NSObject<NSSecureCoding>

@property(nonatomic,copy)NSString *account;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *type;

// 归档
- (void)saveToFile;
// 解档
+ (AcountModel *)readFromFile;

// 删档
+ (void)removeFile;


@end


NS_ASSUME_NONNULL_END
