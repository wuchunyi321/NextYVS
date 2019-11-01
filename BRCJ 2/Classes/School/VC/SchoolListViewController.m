//
//  SchoolListViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/9/20.
//  Copyright © 2019 cy. All rights reserved.
//

#import "SchoolListViewController.h"

#import "SchoolCell.h"
#import "SchoolListItem.h"

@interface SchoolListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger pageIndex;
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation SchoolListViewController

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
    }
    return _tableView;
}

- (void)initTheData{
    [JKRequest requestSchoolEspeciallyPageNumber:[NSString stringWithFormat:@"%ld",(long)pageIndex]
                                        PageSize:@"20"
                                        AnchorId:self.anchorId
                                         success:^(id responseObject) {
                                             if (self->pageIndex == 1) {
                                                 [self.dataArray removeAllObjects];
                                             }
                                             NSArray *array = [JKModelConvert dataModelWithClass:[SchoolListItem class] andSource:responseObject[@"data"][@"list"]];
                                             [self.dataArray addObjectsFromArray:array];
                                             [self.tableView reloadData];
                                             if (array.count == 20){
                                                 self.tableView.mj_footer.hidden = NO;
                                             }else{
                                                 self.tableView.mj_footer.hidden = YES;
                                             }
                                             [self.tableView.mj_header endRefreshing];
                                             [self.tableView.mj_footer endRefreshing];
                                         }
                                         failure:^(NSString *errorMessage , id responseObject) {
                                             JK_HUD_NO(errorMessage);
                                         }];
}

- (void)loadMoreData{
    pageIndex ++;
    [self initTheData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-200-BottomHeight-TopStatus);
    [self.tableView registerClass:[SchoolCell class] forCellReuseIdentifier:@"SchoolCell"];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    [self initTheData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark --- UITableViewdelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

//弹出框消失
- (void)handleDisMiss{
    if (_delegate && [_delegate respondsToSelector:@selector(disMissListVC)]) {
        [_delegate performSelector:@selector(disMissListVC)];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    
    UILabel *titleLbael = [UILabel new];
    titleLbael.text = @"回看列表";
    titleLbael.textColor = RGBCOLOR(0, 0, 0);
    titleLbael.textAlignment = NSTextAlignmentLeft;
    titleLbael.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:16];
    [view addSubview:titleLbael];
    titleLbael.frame = CGRectMake(16, 0, SCREEN_WIDTH-32, 44);

    UIButton *dissmissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dissmissBtn addTarget:self action:@selector(handleDisMiss) forControlEvents:UIControlEventTouchUpInside];
    dissmissBtn.frame = CGRectMake(SCREEN_WIDTH-32-44, 0, 44, 44);
    dissmissBtn.backgroundColor = [UIColor redColor];
    [view addSubview:dissmissBtn];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 108;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchoolCell"];
    [cell loadTheCellWith:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SchoolListItem *item = [self.dataArray objectAtIndex:indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(chooseItemWithUrl:)]) {
        [_delegate performSelector:@selector(chooseItemWithUrl:) withObject:item.videoUrl];
    }
}

@end
