//
//  MineMessageCell.h
//  BRCJ
//
//  Created by wuchunyi on 2019/9/25.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MineMessageModel;

@interface MineMessageCell : UITableViewCell

- (void)loadTheCellWith:(MineMessageModel *)item;

@end

NS_ASSUME_NONNULL_END
