//
//  CardItemView.h
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CardItemView;
@class ReportPersonModel;

@protocol CardItemViewDelegate <NSObject>
@optional
-(void)viewClicked:(CardItemView *)imageView;
@end

@interface CardItemView : UIView

@property (nonatomic,weak)id<CardItemViewDelegate> delegate;

@property (nonatomic,assign)NSInteger  userId;

- (void)loadTheViewWith:(ReportPersonModel *)item;

@end

NS_ASSUME_NONNULL_END
