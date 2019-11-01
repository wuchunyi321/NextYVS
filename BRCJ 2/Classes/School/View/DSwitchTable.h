//
//  DSwitchTable.h
//  Doctor
//
//  Created by wuchunyi on 2017/12/25.
//  Copyright © 2017年 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSwitchTable;

@protocol DSwitchTableDelegate<NSObject>


/** 获取有几项 **/
//- (NSInteger)numberOfTabs:(DSwitchTable *)switchTable;
/** 每一项的标题**/
- (NSArray *)titlesOfSwitchTable:(DSwitchTable *)switchTable;
/** 每一项的VC显示**/
- (UIViewController *)contentOfSwitchTable:(DSwitchTable *)switchTable atIndexPath:(NSIndexPath *)indexPath;
/** 每一项选中时候**/
- (void)switchTable:(DSwitchTable *)switchTable didSelectedTab:(NSIndexPath *)indexPath;
/** 每一项未选中时候**/
- (void)switchTable:(DSwitchTable *)switchTable didDeSelectedTab:(NSIndexPath *)indexPath;

@end

@interface DSwitchTable : UIView

@property (nonatomic,assign)id<DSwitchTableDelegate>delegate;

@property (nonatomic,assign)NSInteger  selectedIndex;

@property (nonatomic,assign)int type;

@end
