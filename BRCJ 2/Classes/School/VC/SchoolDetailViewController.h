//
//  SchoolDetailViewController.h
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import "BRBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SchoolDetailViewController : BRBaseViewController

/** 详情 1，技术；2，信息；3，基本；4，政策 **/
@property (nonatomic,assign)NSString  *detailType;

@end

NS_ASSUME_NONNULL_END
