//
//  MineCardImageView.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/6.
//  Copyright © 2019 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BankCardModel;

@class MineCardImageView;

@protocol MineCardImageViewDelegate <NSObject>
@optional
-(void)viewClicked:(MineCardImageView *)imageView;
@end

#define CARDWIDTH     343*mulNumber
#define CARDHEIGHT    64*mulNumber

@interface MineCardImageView : UIImageView

@property (nonatomic,weak)id<MineCardImageViewDelegate> delegate;


/** 测试数据 **/
-(void)loadTheCardImageWith:(NSString *)title
                       info:(NSString *)info
                   isChoose:(BOOL)ischoose
                   hasArrow:(BOOL) hasArrow;
- (void)loadTheCellWith:(BankCardModel *)model;





@end

NS_ASSUME_NONNULL_END
