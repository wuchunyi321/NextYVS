//
//  MineHomeTableCell.h
//  BRCJ
//
//  Created by wuchunyi on 2019/7/30.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,MineHomeTableCellType) {
    MineHomeTableCellTypeInvate,
    MineHomeTableCellTypeAboutUs,
    MineHomeTableCellTypeReport,
    MineHomeTableCellTypeMyFriends,
    MineHomeTableCellTypeCallUs,
    MineHomeTableCellTypeSet,
    MineHomeTableCellTypeAvatar,
    MineHomeTableCellTypePay
};

@interface MineHomeTableCell : UITableViewCell

- (void)loadTheCellWithType:(MineHomeTableCellType )type;

@end

NS_ASSUME_NONNULL_END
