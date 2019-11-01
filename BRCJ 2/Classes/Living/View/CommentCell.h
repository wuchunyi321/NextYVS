//
//  CommentCell.h
//  BRCJ
//
//  Created by wuchunyi on 2019/9/19.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CommentModel;

@interface CommentCell : UITableViewCell

- (void)loadTheCellWith:(CommentModel *)item;

@end

NS_ASSUME_NONNULL_END
