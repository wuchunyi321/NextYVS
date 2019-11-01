//
//  ReportNormalCell.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/2.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReportListModel;
@class StockModel;

NS_ASSUME_NONNULL_BEGIN

@interface ReportNormalCell : UITableViewCell

/** test **/
-(void)loadTheCell:(NSString *)tittle date:(NSString *)date;

- (void)loadTheCellWith:(ReportListModel *)item;

- (void)loadStockTheCellWith:(StockModel *)item;

@end

NS_ASSUME_NONNULL_END
