//
//  SchoolInfoViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/9/23.
//  Copyright © 2019 cy. All rights reserved.
//

#import "SchoolInfoViewController.h"
#import "SchoolCell.h"
#import "SchoolListItem.h"
#import "StockModel.h"
#import "AnchorModel.h"

#import "CQBlockAlertView.h"
#import "PayModel.h"

//#import <AlipaySDK/AlipaySDK.h>
//#import "WXApiRequestHandler.h"
//#import "WXApi.h"

#define S_BG_WIDTH            375*mulNumber
#define S_BG_HEIGHT           327*mulNumber

@interface SchoolInfoViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger pageIndex;
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIImageView *avatar;
@property (nonatomic,strong)UILabel      *nameLabel;
@property (nonatomic,strong)UILabel      *detailLabel;
@property (nonatomic,strong)UILabel      *pages_1;
@property (nonatomic,strong)UILabel      *pages_2;
@property (nonatomic,strong)UITextView   *infoView;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation SchoolInfoViewController


- (UIImageView *)avatar{
    if(!_avatar){
        _avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BRSource.bundle/report_avatar_default"]];
        _avatar.layer.cornerRadius = 37.5;
        _avatar.layer.masksToBounds = YES;
    }
    return _avatar;
}

- (UITextView *)infoView{
    if (!_infoView) {
        _infoView = [UITextView new];
        _infoView.textColor = [UIColor whiteColor];
        _infoView.backgroundColor = [UIColor clearColor];
        _infoView.textAlignment = NSTextAlignmentLeft;
        _infoView.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:13];
        _infoView.editable = NO;
    }
    return _infoView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Bold" size:18];
    }
    return _nameLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:12];
    }
    return _detailLabel;
}

- (UILabel *)pages_1{
    if (!_pages_1) {
        _pages_1 = [UILabel new];
        _pages_1.textColor = [UIColor whiteColor];
        _pages_1.textAlignment = NSTextAlignmentLeft;
        _pages_1.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:12];
    }
    return _pages_1;
}

- (UILabel *)pages_2{
    if (!_pages_2) {
        _pages_2 = [UILabel new];
        _pages_2.textColor = [UIColor whiteColor];
        _pages_2.textAlignment = NSTextAlignmentLeft;
        _pages_2.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:12];
    }
    return _pages_2;
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initTheData{
    
    if (self.type == 1 || self.type == 3) {
        [JKRequest requestGetStockPlayWithType:@""
                                     pageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]
                                      pageSize:@"20"
                                      anchorId:self.anchorItem.a_id
                                       success:^(id responseObject) {
                                           if (self->pageIndex == 1) {
                                               [self.dataArray removeAllObjects];
                                           }
                                           NSArray *array = [JKModelConvert dataModelWithClass:[StockModel class] andSource:responseObject[@"list"]];
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
                                       failure:^(NSString *errorMessage, id responseObject) {
                                           JK_HUD_NO(errorMessage);
                                       }];
    }else{
        [JKRequest requestSchoolEspeciallyPageNumber:[NSString stringWithFormat:@"%ld",(long)pageIndex]
                                            PageSize:@"20"
                                            AnchorId:self.anchorItem.a_id
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
                                             failure:^(NSString *errorMessage,id responseObject) {
                                                 JK_HUD_NO(errorMessage);
                                             }];
    }
}

- (void)initTheView{
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BRSource.bundle/school_bg"]];
    bgImage.userInteractionEnabled = YES;
    [self.view addSubview:bgImage];
    
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(S_BG_HEIGHT);
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"BRSource.bundle/nav_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [bgImage addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(5);
        make.height.width.mas_equalTo(44);
    }];
    
    [bgImage addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.width.height.mas_equalTo(75);
        make.top.equalTo(self.view).offset(80);
    }];
    
    [bgImage addSubview:self.nameLabel];
    self.nameLabel.text = self.anchorItem.anchorName;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(20);
        make.top.equalTo(self.avatar).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(18);
    }];
    
    [bgImage addSubview:self.detailLabel];
    self.detailLabel.text = self.anchorItem.securitiesCode;
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(20);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.right.equalTo(bgImage).offset(-12);
        make.height.mas_equalTo(13);
    }];
    
    [bgImage addSubview:self.pages_1];
    self.pages_1.text = self.anchorItem.securitiesCodeSecond;
    [self.pages_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(20);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(5);
        make.right.equalTo(bgImage).offset(-12);
        make.height.mas_equalTo(13);
    }];
    
    [bgImage addSubview:self.pages_2];
    self.pages_2.text = self.anchorItem.securitiesCodeThree;
    [self.pages_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(20);
        make.top.equalTo(self.pages_1.mas_bottom).offset(5);
        make.right.equalTo(bgImage).offset(-12);
        make.height.mas_equalTo(13);
    }];
    
    
    [bgImage addSubview:self.infoView];
    self.infoView.text = self.anchorItem.anchorIntroduction;
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.top.equalTo(self.avatar.mas_bottom).offset(15);
        make.height.mas_equalTo(80);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SchoolCell class] forCellReuseIdentifier:@"SchoolCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(bgImage.mas_bottom);
    }];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:self.anchorItem.headPortrait] placeholderImage:[UIImage imageNamed:@"BRSource.bundle/report_avatar_default"]];
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
    pageIndex = 1;
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

#pragma mark --- UITableViewdelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 108;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchoolCell"];
    if (self.type == 1 || self.type == 3) {
        [cell loadTheStockWith:[self.dataArray objectAtIndex:indexPath.row]];
    }else
        [cell loadTheCellWith:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

//- (void)doAPPayWithPrice:(NSString *)price{
//    NSString *appScheme = @"BRCJ";
//    [[AlipaySDK defaultService] payOrder:price fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//        NSLog(@"reslut = %@",resultDic);
//    }];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //传回item
    MyMember *member = [MyMember readFromFile];
    UserInfoModel *user = [UserInfoModel readFromFile];
    BOOL  canLook = NO;
    NSInteger grade;
    if (self.type == 1 || self.type == 3) {
        StockModel *item = [self.dataArray objectAtIndex:indexPath.row];
        grade = item.grade.integerValue;
        if (item.grade.intValue > member.vipLevel.intValue) {
            canLook = NO;
        }else
            canLook = YES;
    }else{
        SchoolListItem *item = [self.dataArray objectAtIndex:indexPath.row];
        grade = item.grade.integerValue;
        if (item.grade.intValue > member.vipLevel.intValue) {
            canLook = NO;
        }else
            canLook = YES;
    }
    
    if (canLook) {
        if (_delegate && [_delegate respondsToSelector:@selector(chooseItemWithUrl:)]) {
            [_delegate performSelector:@selector(chooseItemWithUrl:) withObject:[self.dataArray objectAtIndex:indexPath.row]];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [CQBlockAlertView alertShowWithType:grade
                                VXBackBlock:^{ //微信支付
            if ([TransferDataTool isWXAppInstalled]) {
                    [JKRequest requestPayWithVXRechargeLevel:[BRTool getTheGradeStrWith:grade]
                                                    userId:member.userId
                                                     grade:member.vipLevel
                                                    mobile:user.mobile
                                                   success:^(id responseObject) {
                        NSDictionary *data = responseObject[@"data"];
                        NSString *orderNumber = responseObject[@"order"][@"outTradeNo"];
                        [UserContext setOrderNumber:orderNumber];
//                        [WXApiRequestHandler jumpToBizPayWithStr:data];
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
                    [JKRequest requestPayWithRechargeLevel:[BRTool getTheGradeStrWith:grade]
                                                    userId:member.userId
                                                     grade:member.vipLevel
                                                    mobile:user.mobile
                                                   success:^(id responseObject) {
                        NSString *data = responseObject[@"data"];
                        NSString *orderNumber = responseObject[@"order"][@"outTradeNo"];
                        [UserContext setOrderNumber:orderNumber];
//                       [self doAPPayWithPrice:data];
                        [TransferDataTool zfbPayWith:data];
                    }
                                                   failure:^(NSString *errorMessage, id responseObject) {
                        NSLog(@"订单信息获取失败");
                    }];
        }];
    }
}

@end
