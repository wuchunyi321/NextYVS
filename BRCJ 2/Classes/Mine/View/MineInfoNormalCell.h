//
//  MineInfoNormalCell.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/5.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



typedef NS_ENUM(NSInteger,MineInfoNormalCellType) {
    MineInfoNormalCellTypeAvatar,
    MineInfoNormalCellTypeNickName,
    MineInfoNormalCellTypeSex,
    MineInfoNormalCellTypeName,
    MineInfoNormalCellTypePhone,
    MineInfoNormalCellTypeMoney,
    MineInfoNormalCellTypeClear, //清除缓存
    MineInfoNormalCellTypeVersionUpdate //版本更新
};

@interface MineInfoNormalCell : UITableViewCell

- (void)loadTheCellWithType:(MineInfoNormalCellType )type value:(NSString *)value;


@end

NS_ASSUME_NONNULL_END
