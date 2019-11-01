//
//  MineMessageViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/9/25.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineMessageViewController.h"

#import "MineMessageModel.h"
#import "MineMessageCell.h"

#import "JKNoneDataView.h"

@interface MineMessageViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger pageIndex;
}

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)JKNoneDataView *noneDataView;

@end

@implementation MineMessageViewController

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
        _tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    }
    return _tableView;
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
    [JKRequest requestMessageListWithPage:[NSString stringWithFormat:@"%ld",(long)pageIndex]
                                 pageSize:@"20"
                                  success:^(id responseObject) {
                                      if (self->pageIndex == 1) {
                                          [self.dataArray removeAllObjects];
                                      }
                                      [self.dataArray removeAllObjects];
                                      NSArray *array = [JKModelConvert dataModelWithClass:[MineMessageModel class] andSource:responseObject[@"data"][@"list"]];
                                      [self.dataArray addObjectsFromArray:array];
                                      [self.tableView reloadData];
        [self.noneDataView setHidden:self.dataArray.count > 0];
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
    [self.tableView registerClass:[MineMessageCell class] forCellReuseIdentifier:@"MineMessageCell"];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineMessageModel *item = [self.dataArray objectAtIndex:indexPath.row];
    NSDictionary *dict = [BRTool dictionaryWithJsonString:item.message];
    CGFloat messageHeight = [UserContext getTheHeightOfStr:dict?dict[@"msg"]:@"未知错误" withWidth:SCREEN_WIDTH-30 AndFont:14];
    return messageHeight+15+20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineMessageCell"];
    [cell loadTheCellWith:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
