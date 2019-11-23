//
//  ReporterInfoViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/1.
//  Copyright © 2019 cy. All rights reserved.
//

#import "ReporterInfoViewController.h"
#import "NewsDetailViewController.h"
#import "ReportNormalCell.h"

#import "ReportListModel.h"
#import "ReportPersonModel.h"

#import "CQBlockAlertView.h"
#import <AlipaySDK/AlipaySDK.h>


#define R_BG_WIDTH            375*mulNumber
#define R_BG_HEIGHT           327*mulNumber

@interface ReporterInfoViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger pageIndex;
}

@property (nonatomic,strong)UITableView  *tableView;
@property (nonatomic,strong)UIImageView *avatar;
@property (nonatomic,strong)UILabel      *nameLabel;
@property (nonatomic,strong)UILabel      *detailLabel;
@property (nonatomic,strong)UILabel      *pages_1;
@property (nonatomic,strong)UILabel      *pages_2;

@property (nonatomic,strong)UITextView   *infoView;

@property (nonatomic,strong)NSMutableArray  *dataArray;

@end

@implementation ReporterInfoViewController

- (UIImageView *)avatar{
    if(!_avatar){
        _avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"report_avatar_default"]];
        _avatar.layer.borderWidth = 0.5;
        _avatar.layer.borderColor = UIColorFromRGB(0xf0f0f0).CGColor;
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
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

- (void)back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initTheData{
    [JKRequest requestReportListWithPageIndex:[NSNumber numberWithInteger:pageIndex]
                                     PageSize:@20
                                       userId:self.mdoel.userId
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pageIndex = 1;
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"report_bg"]];
    bgImage.userInteractionEnabled = YES;
    [self.view addSubview:bgImage];
    
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(R_BG_HEIGHT);
    }];
    /**
     */
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
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
        make.top.equalTo(self.view).offset(75);
    }];
    
    [bgImage addSubview:self.nameLabel];
    self.nameLabel.text = self.mdoel.name;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(20);
        make.top.equalTo(self.avatar).offset(-5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(18);
    }];
    
    [bgImage addSubview:self.detailLabel];
    self.detailLabel.text = self.mdoel.securitiesCode;
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(20);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(14);
        make.right.equalTo(bgImage).offset(-12);
        make.height.mas_equalTo(13);
    }];
    
    [bgImage addSubview:self.pages_1];
    self.pages_1.text = self.mdoel.securitiesCodeSecond;
    [self.pages_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(20);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(5);
        make.right.equalTo(bgImage).offset(-12);
        make.height.mas_equalTo(13);
    }];
    
    [bgImage addSubview:self.pages_2];
    self.pages_2.text = self.mdoel.securitiesCodeThree;
    [self.pages_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(20);
        make.top.equalTo(self.pages_1.mas_bottom).offset(5);
        make.right.equalTo(bgImage).offset(-12);
        make.height.mas_equalTo(13);
    }];
    
    [bgImage addSubview:self.infoView];
    self.infoView.text = self.mdoel.introduction;
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.top.equalTo(self.avatar.mas_bottom).offset(15);
        make.bottom.equalTo(bgImage).offset(-20);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ReportNormalCell class] forCellReuseIdentifier:@"ReportNormalCell"];
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
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:self.mdoel.headPortrait] placeholderImage:[UIImage imageNamed:@"report_avatar_default"]];
}

- (void)loadNewData{
    pageIndex = 1;
    [self initTheData];
}

- (void)loadMoreData{
    pageIndex ++;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReportListModel *item = [self.dataArray objectAtIndex:indexPath.row];
    ReportNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportNormalCell"];
    [cell loadTheCellWith:item];
    return cell;
}

- (void)doAPPayWithPrice:(NSString *)price
{
//    // 重要说明
//    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
//    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
//    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
//    /*============================================================================*/
//    /*=======================需要填写商户app申请的===================================*/
//    /*============================================================================*/
//    NSString *appID = @"2019111969259533";
//
//    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
//    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
//    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
//    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
//    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
//    NSString *rsa2PrivateKey = @"MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCPJvF4hU/thgiYSqfNOadxoS1tgDLLNmo+qa5GEE+ILNshXqVe/b7nxqXQ6yPyL7qyMB+Jv8Q1XXbixAtZ9YALSgA7KxVqu2lPQ8Efs++AQRh2FVOJ3kk420TPZHlhpwM4lPxHbqunlfkWgsOWDRra3kKQWluRwIJl7K3wtxV+pDvwZUAtX344Sw0pPokV+hQf5SigDA5wFoqjYxFHg2fXEc9UaK73DvRwKnDigccBfdcUWZ9v8rWSO8NCZ35QT2Rq5kVFtx6ceN6pdf7hvLGJ8lk8PGgm6MnMZzynPJZXAwLOKMEk7yHs0BQx4oeX88FAbWyzwUF+eMv7QX3VnzDxAgMBAAECggEAfa++kYfS/oQRJc1eeVTmjGDsZtkJP9y9+di3N7L4cWKY3zqfTcDSjeOfEMhznh+D9xFDj4k8t3IhgMaKBOkFDGRjwY95VWXI95xQgwpT/TKqTHs7BrCRb4ctaj4YSMH/lP1SZ1FnC1QlCDu1iBhnfMVqgh2jilwQ4Xal3dSR3cbxqdxrPto/0vFa+8P3Lnnq9tXAuYC8e+GGPbieDnzXU4CYUNqjz6iUnWC0KEdvM6iGpf2TX18B/QjSq3/Ivl8TfUT+SsNRolUaNkhIQSkSsrSKOfvznT59P1Ew+Z+GUD+Gf/oKb/u9NnugRhjHsUrKEPMaWXMcKeiNstzDkSbmsQKBgQDx2r1Ftq4F0CW9vsLnGw/Yw5eug6zjFqvpLXckrxVifHiMLZlEGsVrPG43wx+tJkZTu+Q5yAbogK00zfiSMLcgNtjpenRV1NDhCp6QPsWLC0p4dzTCwoLGWAI2jWDUz2tJTFvdU8njSThUBgO5MkO2ReD8T0XJOm4suXjQEygEXQKBgQCXhlg1EbLeZ13KZi94c4E07/LO7Oqp08OXp2iQYEU+AGL59YY94lu/uq92BUYZ7nksrTu6PrtOKkIwz5CK2YmDn0+el6ZVWQB3MA8nTcP97yb0hDUF8YwLuw09QZBD/kHVVVNixgkZdArld/T427Da/1Sck9lJoHdgD75xss/VpQKBgQDB0EATaNTGVcqY5xE7sKUfWYbpVB4tEZMMVuH+pMwnU4YrF7OWLzn7uL6+swBkeqKrIYxAfbqDgfLLuS+0v5NRHoLvf7FQwy3s2dy9zX/y8EZqiWTfmo7AMfD8FIn/oITihW2szSOhn6CjPPqo4839eLxWlZRgMRHvh2Z4oJFWBQKBgG62/RCZxAZ5pLBVBe6PByO1B8dmmPhKASp4ahDEJxPsmGVnnxTspnlrYPVtWRFtjCC222N0nsu4WPDtWQH7fV0tNLH+wMyv4YU1Gn1vdvu+mMolJ9EV82xG2p+dnlnwGA5W8DzF0rREdAnDIr4LWChMVHisFyKTG2aXWmIdc3r5AoGAGzPYWUVTMKl8EqgyHtKpv02G6Y41HKz7gM6xqTM0nQ/zHBdo9kV7Hga+OFTywWguvHiN7EupP0xVac+ni84OKlfsFCZdYX/EgjUh/029m1caxCKpSQhSiICKBRpncd3zLz+nucL4OVQ95zWMbdWvDW5Kp/wDYJ+DfutSH1HJ6dE=";
//    NSString *rsaPrivateKey = @"";
//    /*============================================================================*/
//    /*============================================================================*/
//    /*============================================================================*/
//
//    //partner和seller获取失败,提示
//    if ([appID length] == 0 ||
//        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
//    {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
//                                                                       message:@"缺少appId或者私钥,请检查参数设置"
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
//                                                         style:UIAlertActionStyleDefault
//                                                       handler:^(UIAlertAction *action){
//
//                                                       }];
//        [alert addAction:action];
//        [self presentViewController:alert animated:YES completion:^{ }];
//        return;
//    }
//
//    /*
//     *生成订单信息及签名
//     */
//    //将商品信息赋予AlixPayOrder的成员变量
//    APOrderInfo* order = [APOrderInfo new];
//
//    // NOTE: app_id设置
//    order.app_id = appID;
//
//    // NOTE: 支付接口名称
//    order.method = @"alipay.trade.app.pay";
//
//    // NOTE: 参数编码格式
//    order.charset = @"utf-8";
//
//    // NOTE: 当前时间点
//    NSDateFormatter* formatter = [NSDateFormatter new];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    order.timestamp = [formatter stringFromDate:[NSDate date]];
//
//    // NOTE: 支付版本
//    order.version = @"1.0";
//
//    // NOTE: sign_type 根据商户设置的私钥来决定
//    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
//
//    // NOTE: 商品数据
//    order.biz_content = [APBizContent new];
//    order.biz_content.body = @"我是测试数据";
//    order.biz_content.subject = @"1";
//    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
//    order.biz_content.timeout_express = @"30m"; //超时时间设置
//    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
//
//    //将商品信息拼接成字符串
//    NSString *orderInfo = [order orderInfoEncoded:NO];
//    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
//    NSLog(@"orderSpec = %@",orderInfo);
//
//    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
//    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
//    NSString *signedString = nil;
//    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
//    if ((rsa2PrivateKey.length > 1)) {
//        signedString = [signer signString:orderInfo withRSA2:YES];
//    } else {
//        signedString = [signer signString:orderInfo withRSA2:NO];
//    }
    
    // NOTE: 如果加签成功，则继续执行支付
//    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"BRCJ";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
//        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
//                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:price fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReportListModel *item = [self.dataArray objectAtIndex:indexPath.row];
    MyMember *member = [MyMember readFromFile];
    UserInfoModel *user = [UserInfoModel readFromFile];
    if (item.grade.intValue > member.vipLevel.intValue) {
        
        [JKRequest requestPayWithVXRechargeLevel:[BRTool getTheGradeStrWith:item.grade.intValue]
                                        userId:member.userId
                                         grade:member.vipLevel
                                        mobile:user.mobile
                                       success:^(id responseObject) {
            
            
            
//            NSString *data = responseObject[@"data"];
//            [self doAPPayWithPrice:data];
        }
                                       failure:^(NSString *errorMessage, id responseObject) {

        }];
        
        
        
        
//        [CQBlockAlertView alertShowWithType:item.grade.integerValue price:@""];
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
