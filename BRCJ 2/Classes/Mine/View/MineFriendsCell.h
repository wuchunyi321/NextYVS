//
//  MineFriendsCell.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/21.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FriendsModel;

@interface MineFriendsCell : UITableViewCell

- (void)loadTheCellWith:(FriendsModel *)item;


@end

NS_ASSUME_NONNULL_END
