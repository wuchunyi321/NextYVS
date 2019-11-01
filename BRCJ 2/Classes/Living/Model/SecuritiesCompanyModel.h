//
//  SecuritiesCompanyModel.h
//  BRCJ
//
//  Created by wuchunyi on 2019/10/15.
//  Copyright © 2019 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface SecuritiesCompanyModel : NSObject

@property(nonatomic,copy)NSString *s_id;
@property(nonatomic,copy)NSString *companyName;
@property(nonatomic,copy)NSString *companyIntroduce;
@property(nonatomic,copy)NSString *companyLogo;
@property(nonatomic,copy)NSString *favouredPolicy;
@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *delFlag;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSString *jumpAddress;

@end

NS_ASSUME_NONNULL_END
