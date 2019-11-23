//
//  StockListController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/22.
//  Copyright © 2019 cy. All rights reserved.
//

#import "StockListController.h"

/** 视频类型 **/
#import "SchoolCell.h"
/** 文章类型 **/
#import "ReportNormalCell.h"

/** 文章 **/
#import "NewsDetailViewController.h"
/** 视频 **/
#import "SchoolItemInfoViewController.h"

#import "CQBlockAlertView.h"

#import "StockModel.h"

#import "JKNoneDataView.h"

@interface StockListController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger pageIndex;
}

@property (nonatomic,strong)UITableView  *tableView;

@property (nonatomic,strong)NSMutableArray  *dataArray;


@property (nonatomic,strong)JKNoneDataView *noneDataView;

@end



@implementation StockListController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)initTheView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self.tableView registerClass:[SchoolCell class] forCellReuseIdentifier:@"SchoolCell"];
    [self.tableView registerClass:[ReportNormalCell class] forCellReuseIdentifier:@"ReportNormalCell"];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)loadNewData{
    pageIndex = 1;
    [self initTheData];
}

- (void)loadMoreData{
    pageIndex ++ ;
    [self initTheData];
}
- (void)initTheData{
    
    if ([self.type isEqualToString:@"888"]) {
        [JKRequest requestHomeNewVideoListWithPage:[NSString stringWithFormat:@"%ld",(long)pageIndex]
                                          pageSize:@"20"
                                           Success:^(id responseObject) {
            if (self->pageIndex == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray removeAllObjects];
            NSArray *array = [JKModelConvert dataModelWithClass:[StockModel class] andSource:responseObject[@"data"][@"list"]];
            [self.dataArray addObjectsFromArray:array];
            [self.noneDataView setHidden:self.dataArray.count > 0];
            [self.tableView reloadData];
            if (array.count == 20){
                self.tableView.mj_footer.hidden = NO;
            }else{
                self.tableView.mj_footer.hidden = YES;
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
                                           failure:^(NSString *errorMessage, id responseObject) {
            JK_HUD_NO(errorMessage);
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }];
    }else{
        [JKRequest requestGetStockListWithType:self.type
                                     PageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]
                                      pageSize:@"20"
                                      classify:@"1"
                                       success:^(id responseObject) {
                                           if (self->pageIndex == 1) {
                                               [self.dataArray removeAllObjects];
                                           }
                                           [self.dataArray removeAllObjects];
                                           NSArray *array = [JKModelConvert dataModelWithClass:[StockModel class] andSource:responseObject[@"list"]];
                                           [self.dataArray addObjectsFromArray:array];
                                           [self.noneDataView setHidden:self.dataArray.count > 0];
                                           [self.tableView reloadData];
                                           if (array.count == 20){
                                               self.tableView.mj_footer.hidden = NO;
                                           }else{
                                               self.tableView.mj_footer.hidden = YES;
                                           }
                                           [self.tableView.mj_header endRefreshing];
                                           [self.tableView.mj_footer endRefreshing];
                                           
                                       } failure:^(NSString *errorMessage,id responseObject) {
                                           JK_HUD_NO(errorMessage);
                                           [self.tableView.mj_header endRefreshing];
                                           [self.tableView.mj_footer endRefreshing];
                                       }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTheView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StockModel *item = [self.dataArray objectAtIndex:indexPath.row];
    if (item.classify.intValue == 1) { //视频
        return 108;
    }else{ //文章
        return 70;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StockModel *item = [self.dataArray objectAtIndex:indexPath.row];
    if (item.classify.intValue == 1) {
        SchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchoolCell"];
        [cell loadTheStockWith:item];
        return cell;
    }else{
        ReportNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportNormalCell"];
        [cell loadStockTheCellWith:item];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StockModel *item = [self.dataArray objectAtIndex:indexPath.row];
    MyMember *member = [MyMember readFromFile];
    if (item.grade.intValue > member.vipLevel.intValue) {
//        [CQBlockAlertView alertShowWithType:item.grade.integerValue price:@""];
    }else{
        if (item.classify.intValue == 1) {
            /** 音视频
             */
            SchoolItemInfoViewController *infoVC = [[SchoolItemInfoViewController alloc] init];
            infoVC.type = self.type.intValue == 888?3:1;
            infoVC.sotckItem = item;
            [self.navigationController pushViewController:infoVC animated:YES];
        }else{
            /** 文章
             */
            NewsDetailViewController *reportVC = [[NewsDetailViewController alloc] init];
            reportVC.title = @"文章";
            reportVC.type = 1;
            reportVC.stockItem = item;
            [self.navigationController pushViewController:reportVC animated:YES];
        }
    }
}

#pragma mark - noneDataView
-(JKNoneDataView *)noneDataView{
    if (!_noneDataView) {
        _noneDataView =[JKNoneDataView initNoneDataViewWithFrame:self.tableView.bounds type:@"暂无数据"];
        [self.tableView addSubview:_noneDataView];
        _noneDataView.hidden =YES;
    }
    return _noneDataView;
}


@end
