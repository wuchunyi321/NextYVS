//
//  SchoolAuthorCell.h
//  BRCJ
//
//  Created by wuchunyi on 2019/9/23.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnchorModel;

NS_ASSUME_NONNULL_BEGIN

@interface SchoolAuthorCell : UITableViewCell

- (void)loadTheCellWith:(AnchorModel *)item avatar:(NSString *)avatarUrl;

@end

NS_ASSUME_NONNULL_END
