//
//  MineCardListCell.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/6.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BankCardModel;

NS_ASSUME_NONNULL_BEGIN

@interface MineCardListCell : UITableViewCell

/** 测试数据 **/
-(void)loadTheCardImageWith:(NSString *)title
                       info:(NSString *)info
                   isChoose:(BOOL)ischoose
                   hasArrow:(BOOL) hasArrow;

- (void)loadTheCellWith:(BankCardModel *)model;

- (void)loadTheListCellWith:(BankCardModel *)model;

@end

NS_ASSUME_NONNULL_END
