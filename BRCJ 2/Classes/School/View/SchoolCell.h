//
//  SchoolCell.h
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SchoolListItem;
@class StockModel;

@interface SchoolCell : UITableViewCell


- (void)loadTheCellWith:(SchoolListItem *)item;

- (void)loadTheStockWith:(StockModel *)item;

@end

NS_ASSUME_NONNULL_END
