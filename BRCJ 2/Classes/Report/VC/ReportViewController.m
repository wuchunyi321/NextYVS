//
//  ReportViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import "ReportViewController.h"

#import "ReportHeadView.h"

#import "ReporterInfoViewController.h"
#import "NewsDetailViewController.h"
#import "ReportNormalCell.h"

#import "ReportPersonModel.h"
#import "ReportListModel.h"

#import "CQBlockAlertView.h"
#import "PayModel.h"

#import <AlipaySDK/AlipaySDK.h>
#import "WXApiRequestHandler.h"

@interface ReportViewController ()<UITableViewDelegate,UITableViewDataSource,CardItemViewDelegate>{
    ReportHeadView  *headerView;
    NSInteger pageIndex;
}

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *personArray;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ReportViewController

- (NSMutableArray *)personArray{
    if (!_personArray) {
        _personArray = [NSMutableArray new];
    }
    return _personArray;
}

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

-(void)viewClicked:(CardItemView *)imageView{
    ReportPersonModel *item = [self.personArray objectAtIndex:imageView.tag-1];
    ReporterInfoViewController *infoVC = [[ReporterInfoViewController alloc] init];
    infoVC.title = @"";
    infoVC.mdoel = item;
    infoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:infoVC animated:YES];
}

- (void)initTheView{
    headerView = [[ReportHeadView alloc] init];
    headerView.userInteractionEnabled = YES;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 188);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self.tableView registerClass:[ReportNormalCell class] forCellReuseIdentifier:@"ReportNormalCell"];
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = [UIView new];
    
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

- (void)loadTheList{
    [JKRequest requestReportListWithPageIndex:[NSNumber numberWithInteger:pageIndex]
                                     PageSize:@20
                                       userId:@""
                                       status:@"3"
                                        grade:@""
                                      success:^(id responseObject) {
                                          NSLog(@"back == %@",responseObject);
                                          if (self->pageIndex == 1) {
                                              [self.dataArray removeAllObjects];
                                          }
                                          NSArray *array = responseObject[@"data"][@"list"];
                                          NSArray *items = [JKModelConvert dataModelWithClass:[ReportListModel class] andSource:array];
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
                                      failure:^(NSString *errorMessage,id responseObject) {
                                          JK_HUD_NO(errorMessage);
                                          [self.tableView.mj_header endRefreshing];
                                          [self.tableView.mj_footer endRefreshing];
                                      }];
}

- (void)loadNewData{
    pageIndex = 1;
    [self loadTheList];
}

- (void)loadMoreData{
    pageIndex ++;
    [self loadTheList];
}

- (void)initTheData{
    [JKRequest requestReportPersonListsuccess:^(id responseObject) {
        NSArray *array = [JKModelConvert dataModelWithClass:[ReportPersonModel class] andSource:responseObject[@"data"]];
        [self.personArray removeAllObjects];
        [self.personArray addObjectsFromArray:array];
        [self->headerView loadTheViewWith:self.personArray withDelegate:self];
    } failure:^(NSString *errorMessage,id responseObject) {
        JK_HUD_NO(errorMessage);
    }];
}

- (void)viewDidLoad {
    pageIndex = 1;
    [super viewDidLoad];
    [self hideBackButton];
    // Do any additional setup after loading the view.
    [self initTheView];
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


#pragma mark --- UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLbael = [UILabel new];
    titleLbael.textColor = RGBCOLOR(34, 34, 34);
    titleLbael.text = @"精选内容";
    titleLbael.textAlignment = NSTextAlignmentLeft;
    titleLbael.backgroundColor = [UIColor clearColor];
    titleLbael.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:16];
    [view addSubview:titleLbael];
    titleLbael.frame = CGRectMake(20+4+10, 10, 150, 20);
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = RGBCOLOR(255, 52, 58);
    [view addSubview:lineView];
    lineView.frame = CGRectMake(20, 10, 4, 20);
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReportListModel *item = [self.dataArray objectAtIndex:indexPath.row];
    ReportNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportNormalCell"];
    [cell loadTheCellWith:item];
    return cell;
}

- (void)doAPPayWithPrice:(NSString *)price{
    NSString *appScheme = @"BRCJ";
    [[AlipaySDK defaultService] payOrder:price fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReportListModel *item = [self.dataArray objectAtIndex:indexPath.row];
    MyMember *member = [MyMember readFromFile];
    UserInfoModel *user = [UserInfoModel readFromFile];
    
    if (item.grade.intValue > member.vipLevel.intValue) {
        
        [CQBlockAlertView alertShowWithType:item.grade.integerValue
                                VXBackBlock:^{ //微信支付
                    [JKRequest requestPayWithVXRechargeLevel:[BRTool getTheGradeStrWith:item.grade.intValue]
                                                    userId:member.userId
                                                     grade:member.vipLevel
                                                    mobile:user.mobile
                                                   success:^(id responseObject) {
                        NSDictionary *data = responseObject[@"data"];
                        NSString *orderNumber = responseObject[@"order"][@"outTradeNo"];
                        [UserContext setOrderNumber:orderNumber];
                        [WXApiRequestHandler jumpToBizPayWithStr:data];
                    }
                                                   failure:^(NSString *errorMessage, id responseObject) {
                        NSLog(@"订单信息获取失败");
                    }];
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
                       [self doAPPayWithPrice:data];
                    }
                                                   failure:^(NSString *errorMessage, id responseObject) {
                        NSLog(@"订单信息获取失败");
                    }];
        }];
    }else{
        NewsDetailViewController *reportVC = [[NewsDetailViewController alloc] init];
        reportVC.title = @"研报";
        reportVC.type = 2;
        reportVC.reportItem = item;
        reportVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:reportVC animated:YES];
    }
}

@end
