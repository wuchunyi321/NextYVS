//
//  StockImageView.h
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class StockImageView;

@protocol StockImageViewDelegate <NSObject>
@optional
-(void)viewClicked:(StockImageView *)imageView;
@end

@interface StockImageView : UIImageView

@property (nonatomic,weak)id<StockImageViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
