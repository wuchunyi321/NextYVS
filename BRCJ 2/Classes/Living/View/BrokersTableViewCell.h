//
//  BrokersTableViewCell.h
//  BRCJ
//
//  Created by wuchunyi on 2019/10/15.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BrokersTableViewCellDelegate <NSObject>

- (void)clickWithIndex:(NSNumber *)index;

@end


@class SecuritiesCompanyModel;

@interface BrokersTableViewCell : UITableViewCell

- (void)loadTheCellWith:(SecuritiesCompanyModel *)item withIndex:(NSInteger)index;

@property (nonatomic,weak)id<BrokersTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
