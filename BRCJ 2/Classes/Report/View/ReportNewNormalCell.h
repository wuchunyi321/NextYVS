//
//  ReportNewNormalCell.h
//  BRCJ
//
//  Created by wuchunyi on 2019/9/29.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReportListModel;

NS_ASSUME_NONNULL_BEGIN

@interface ReportNewNormalCell : UITableViewCell

- (void)loadTheCellWith:(ReportListModel *)item;

@end

NS_ASSUME_NONNULL_END
