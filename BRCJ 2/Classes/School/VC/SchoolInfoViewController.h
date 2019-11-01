//
//  SchoolInfoViewController.h
//  BRCJ
//
//  Created by wuchunyi on 2019/9/23.
//  Copyright © 2019 cy. All rights reserved.
//

#import "BRBaseViewController.h"

@class AnchorModel;

@class SchoolInfoViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol SchoolInfoViewControllerDelegate <NSObject>

- (void)chooseItemWithUrl:(id)item;

@end

@interface SchoolInfoViewController : BRBaseViewController

@property (nonatomic,strong)AnchorModel *anchorItem;

@property (nonatomic,weak)id<SchoolInfoViewControllerDelegate> delegate;

/** 1是其他还是学堂 可以是1，2，3(1和3一样)
 */
@property (nonatomic,assign)NSInteger type;

@end

NS_ASSUME_NONNULL_END
