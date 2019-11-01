//
//  NewsDetailViewController.h
//  TSQ
//
//  Created by wuchunyi on 16/11/14.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "BRBaseViewController.h"

//@class NewsModel;  //资讯
@class StockModel;
@class ReportListModel;

@interface NewsDetailViewController : BRBaseViewController

//@property (nonatomic,strong)NewsModel   *item;

@property (nonatomic,assign)NSInteger   type; //type == 1时候是；type==2 时候是
@property (nonatomic,strong)StockModel  *stockItem;
@property (nonatomic,strong)ReportListModel *reportItem;

@end
