//
//  LivingNormalCell.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/7.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LivingModel;

NS_ASSUME_NONNULL_BEGIN

@interface LivingNormalCell : UITableViewCell

- (void)loadTheCellWith:(LivingModel *)item;

@end

NS_ASSUME_NONNULL_END
