//
//  SchoolDetailViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import "SchoolDetailViewController.h"

/** 播放列表展示 **/
#import "SchoolItemInfoViewController.h"

#import "CQBlockAlertView.h"

#import "SchoolCell.h"
#import "SchoolListItem.h"

#import "JKNoneDataView.h"

@interface SchoolDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger schollListType;
    NSInteger pageIndex;
}

@property (nonatomic,strong)UITableView *table;

@property (nonatomic,strong)NSMutableArray  *dataArray;

@property (nonatomic,strong)JKNoneDataView *noneDataView;

@end

@implementation SchoolDetailViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc] init];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.backgroundColor = UIColorFromRGB(0xf5f5f5);
    }
    return _table;
}

- (void)initTheData{
    [JKRequest requestSchoolListWithPageNumber:[NSString stringWithFormat:@"%ld",(long)pageIndex]
                                      PageSize:@"20"
                                    schoolType:[NSString stringWithFormat:@"%ld",(long)schollListType]
                                       success:^(id responseObject) {
                                           if (self->pageIndex == 1) {
                                               [self.dataArray removeAllObjects];
                                           }
                                           NSArray *array = (NSArray *)responseObject;
                                           [self.dataArray addObjectsFromArray:array];
        
                                           [self.noneDataView setHidden:self.dataArray.count > 0];
                                           [self.table reloadData];
                                           if (array.count == 20){
                                               self.table.mj_footer.hidden = NO;
                                           }else{
                                               self.table.mj_footer.hidden = YES;
                                           }
                                           [self.table.mj_header endRefreshing];
                                           [self.table.mj_footer endRefreshing];
                                       } failure:^(NSString *errorMessage,id responseObject) {
                                           JK_HUD_NO(errorMessage);
                                           [self.table.mj_header endRefreshing];
                                           [self.table.mj_footer endRefreshing];
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
    
    schollListType = [self.detailType isEqualToString:@"技术"]?1:([self.detailType isEqualToString:@"信息"]?2:([self.detailType isEqualToString:@"基本"]?3:4));
    pageIndex = 1;
    [self.view addSubview:self.table];
    [self.table registerClass:[SchoolCell class] forCellReuseIdentifier:@"SchoolCell"];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(SCREEN_HEIGHT-TopHeight-BottomStatus-40);
    }];
    __weak typeof(self) weakSelf = self;
    self.table.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    // 马上进入刷新状态
    [self.table.mj_header beginRefreshing];
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
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
    return 108;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchoolCell"];
    [cell loadTheCellWith:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SchoolListItem *item = [self.dataArray objectAtIndex:indexPath.row];
    MyMember *member = [MyMember readFromFile];
    UserInfoModel *user = [UserInfoModel readFromFile];
    if (item.grade.intValue > member.vipLevel.intValue) {
        
        [CQBlockAlertView alertShowWithType:item.grade.integerValue
                                VXBackBlock:^{ //微信支付
            if ([TransferDataTool isWXAppInstalled]) {
                    [JKRequest requestPayWithVXRechargeLevel:[BRTool getTheGradeStrWith:item.grade.intValue]
                                                    userId:member.userId
                                                     grade:member.vipLevel
                                                    mobile:user.mobile
                                                   success:^(id responseObject) {
                        NSDictionary *data = responseObject[@"data"];
                        NSString *orderNumber = responseObject[@"order"][@"outTradeNo"];
                        [UserContext setOrderNumber:orderNumber];
                        [TransferDataTool wxPayWith:data];
                    }
                                                   failure:^(NSString *errorMessage, id responseObject) {
                        NSLog(@"订单信息获取失败");
                    }];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"请先安装微信"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
            
        }
                               ZFBBackBlock:^{ //支付宝支付
                    [JKRequest requestPayWithRechargeLevel:[BRTool getTheGradeStrWith:item.grade.intValue]
                                                    userId:member.userId
                                                     grade:member.vipLevel
                                                    mobile:user.mobile
                                                   success:^(id responseObject) {
                        NSString *data = responseObject[@"data"];
                        NSString *orderNumber = responseObject[@"order"][@"outTradeNo"];
                        [UserContext setOrderNumber:orderNumber];
                        [TransferDataTool zfbPayWith:data];
                    }
                                                   failure:^(NSString *errorMessage, id responseObject) {
                        NSLog(@"订单信息获取失败");
                    }];
        }];
    }else{
        SchoolItemInfoViewController *itemVC = [[SchoolItemInfoViewController alloc] init];
        itemVC.title = @"详情";
        itemVC.model = item;
        itemVC.type = 2;
        itemVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:itemVC animated:YES];
    }
}

#pragma mark - noneDataView
-(JKNoneDataView *)noneDataView{
    if (!_noneDataView) {
        _noneDataView =[JKNoneDataView initNoneDataViewWithFrame:self.table.bounds type:@"暂无数据"];
        [self.table addSubview:_noneDataView];
        _noneDataView.hidden =YES;
    }
    return _noneDataView;
}


@end
