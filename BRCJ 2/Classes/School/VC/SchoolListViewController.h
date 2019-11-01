//
//  SchoolListViewController.h
//  BRCJ
//
//  Created by wuchunyi on 2019/9/20.
//  Copyright © 2019 cy. All rights reserved.
//

#import "BRBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class SchoolListItem;

@protocol SchoolListViewControllerDelegate <NSObject>

- (void)disMissListVC;

- (void)chooseItemWithUrl:(id)item;

@end


@interface SchoolListViewController : BRBaseViewController

@property (nonatomic,copy)NSString *anchorId;

@property (nonatomic,weak)id<SchoolListViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
