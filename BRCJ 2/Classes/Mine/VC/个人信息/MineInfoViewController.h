//
//  MineInfoViewController.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/5.
//  Copyright © 2019 cy. All rights reserved.
//

#import "BRBaseViewController.h"




NS_ASSUME_NONNULL_BEGIN

@protocol MineInfoViewControllerDelegate <NSObject>

- (void)updateMyInfo;

@end

@interface MineInfoViewController : BRBaseViewController

@property (nonatomic,weak)id<MineInfoViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
