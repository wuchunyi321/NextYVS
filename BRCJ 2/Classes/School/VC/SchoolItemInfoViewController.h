//
//  SchoolItemInfoViewController.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/1.
//  Copyright © 2019 cy. All rights reserved.
//

#import "BRBaseViewController.h"

@class SchoolListItem;
@class StockModel;

NS_ASSUME_NONNULL_BEGIN

@interface SchoolItemInfoViewController : BRBaseViewController

/**
 type 1是 G type = 0 是 X type = 3 是New
 */

@property (nonatomic,assign)NSInteger    type;

@property (nonatomic,strong)StockModel    *sotckItem;

@property (nonatomic,strong)SchoolListItem *model;

@end

NS_ASSUME_NONNULL_END
