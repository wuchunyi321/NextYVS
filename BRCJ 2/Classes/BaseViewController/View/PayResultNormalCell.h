//
//  PayResultNormalCell.h
//  BRCJ
//
//  Created by wuchunyi on 2019/11/27.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayResultNormalCell : UITableViewCell

/**
 
 */
- (void)loadTheCellWith:(NSString *)content;

/**
 
 */
- (void)loadTheCellWith:(NSString *)content
               content1:(NSString *)content1
               content2:(NSString *)content2;

@end

NS_ASSUME_NONNULL_END
