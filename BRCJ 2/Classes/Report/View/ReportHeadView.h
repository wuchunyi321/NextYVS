//
//  ReportHeadView.h
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "CardItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReportHeadView : UIView



- (void)loadTheViewWith:(NSArray *)items withDelegate:(id<CardItemViewDelegate>)delegate;
/**  test**/
//- (void)loadTestViewWithDelegate:(id<CardItemViewDelegate>)delegate;


@end

NS_ASSUME_NONNULL_END
