//
//  LivingBrokersViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/10/15.
//  Copyright © 2019 cy. All rights reserved.
//

#import "LivingBrokersViewController.h"

#import "BrokersTableViewCell.h"
#import "SecuritiesCompanyModel.h"

#import "BRWebViewController.h"

@interface LivingBrokersViewController ()<UITableViewDelegate,UITableViewDataSource,BrokersTableViewCellDelegate>{
    NSInteger pageIndex;
}

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation LivingBrokersViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

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

- (void)loadNewData{
    pageIndex = 1;
    [self initTheData];
}

- (void)loadMoreData{
    pageIndex ++;
    [self initTheData];
}

- (void)initTheData{
    [JKRequest requestHomeSecuritiescompanyListWithPage:[NSString stringWithFormat:@"%ld",(long)pageIndex]
                                               pageSize:@"20"
                                            companyName:@""
                                                Success:^(id responseObject) {
        NSLog(@"back == %@",responseObject);
        if (self->pageIndex == 1) {
            [self.dataArray removeAllObjects];
        }
        NSArray *array = responseObject[@"data"][@"list"];
        NSArray *items = [JKModelConvert dataModelWithClass:[SecuritiesCompanyModel class] andSource:array];
        [self.dataArray addObjectsFromArray:items];
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
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self.tableView registerClass:[BrokersTableViewCell class]  forCellReuseIdentifier:@"BrokersTableViewCell"];
    
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
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SecuritiesCompanyModel *item = [self.dataArray objectAtIndex:indexPath.row];
    BrokersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokersTableViewCell"];
    cell.delegate = self;
    [cell loadTheCellWith:item withIndex:indexPath.row];
    return cell;
}

- (void)clickWithIndex:(NSNumber *)index{
    SecuritiesCompanyModel *item = [self.dataArray objectAtIndex:index.integerValue-1];
    BRWebViewController *webVC = [[BRWebViewController alloc] init];
    webVC.infoUrl = item.jumpAddress;
    webVC.title = item.companyName;
    webVC.mType = WebTypeWeb;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return;
}

@end
