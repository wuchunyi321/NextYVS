//
//  MainPayListViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/11/26.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MainPayListViewController.h"
/**
 联系我们
 */
#import "BRWebViewController.h"

#import "MinePayCell.h"

@interface MainPayListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger pageIndex;
}
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MainPayListViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    }
    return _tableView;
}

- (void)initTheData{
    [JKRequest requestPayListPageNumber:[NSString stringWithFormat:@"%ld",(long)pageIndex]
                               PageSize:@"20"
                                success:^(id responseObject) {
        
        if (self->pageIndex == 1) {
            [self.dataArray removeAllObjects];
        }
        NSDictionary *dataDict = responseObject[@"data"];
        NSArray *dataAr = [JKModelConvert dataModelWithClass:[MinePayModel class] andSource:dataDict[@"list"]];
        [self.dataArray addObjectsFromArray:dataAr];
        [self.tableView reloadData];
        if (dataAr.count == 20){
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
}

- (void)loadNewData{
    pageIndex = 1;
    [self initTheData];
}

- (void)loadMoreData{
    pageIndex ++;
    [self initTheData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self.tableView registerClass:[MinePayCell class] forCellReuseIdentifier:@"MinePayCell"];
    
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
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 14+223;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MinePayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MinePayCell"];
    __weak typeof(self) weakSelf = self;
    cell.backBlock = ^{ //联系我们
        BRWebViewController *reportVC = [[BRWebViewController alloc] init];
        reportVC.title = @"联系我们";
        reportVC.mType = WebTypeCallUs;
        [weakSelf.navigationController pushViewController:reportVC animated:YES];
    };
    [cell loadTheCellWith:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

@end
