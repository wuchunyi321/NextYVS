//
//  StockBlockView.h
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class StockBlockView;

@protocol StockBlockViewDelegate <NSObject>
@optional
-(void)viewClicked:(StockBlockView *)imageView;
@end


@interface StockBlockView : UIView

@property (nonatomic,weak)id<StockBlockViewDelegate> delegate;

- (void)setWidget;

/** 上证指数 **/
- (void)loadTheShangwith:(NSString *)str;



@end

NS_ASSUME_NONNULL_END
