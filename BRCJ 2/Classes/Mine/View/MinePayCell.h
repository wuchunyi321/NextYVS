//
//  MinePayCell.h
//  BRCJ
//
//  Created by wuchunyi on 2019/11/26.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MinePayModel.h"
NS_ASSUME_NONNULL_BEGIN



@interface MinePayCell : UITableViewCell

@property (nonatomic,copy)noDataBlock  backBlock;

- (void)loadTheCellWith:(MinePayModel *)item;

@end

NS_ASSUME_NONNULL_END
