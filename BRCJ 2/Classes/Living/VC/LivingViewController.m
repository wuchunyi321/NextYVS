//
//  LivingViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import "LivingViewController.h"
#import "LinvingInfoViewController.h"
#import "LivingAdvertiseViewController.h"
#import "BRWebViewController.h"

#import "LivingBrokersViewController.h"

#import "CQBlockAlertView.h"
/** 轮播图
 */
#import "SDCycleScrollView.h"
#import "BannerModel.h"
#import "StockListController.h"
#import "LivingNormalCell.h"
#import "LivingModel.h"

@interface LivingViewController ()
<UITableViewDelegate,
UITableViewDataSource,
SDCycleScrollViewDelegate>{
    /**
     每次加载一次弹出一次
     */
    BOOL  isShow;
}

@property (nonatomic,strong)UITableView  *tableView;

@property (nonatomic,strong)SDCycleScrollView  *bannerView;

@property (nonatomic,strong)NSMutableArray  *dataArray;

@property (nonatomic,strong)NSMutableArray *bannerArray;

@end

@implementation LivingViewController

- (NSMutableArray *)bannerArray{
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray new];
    }
    return _bannerArray;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (SDCycleScrollView *)bannerView{
    if (!_bannerView) {
        
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(13, TopHeight+10, [UIScreen mainScreen].bounds.size.width-26, 121) delegate:self placeholderImage:[UIImage imageNamed:@"BRSource.bundle/banner_default"]];
        _bannerView.layer.cornerRadius = 15;
        _bannerView.layer.masksToBounds = YES;
        
        //背景色
        _bannerView.backgroundColor = [UIColor whiteColor];
        
        //当前分页控件小图标颜色
        _bannerView.currentPageDotColor = [UIColor whiteColor];
        
        //其他分页控件小图标颜色
        _bannerView.pageDotColor = [UIColor grayColor];
        
        //自动滚动时间间隔,默认2s
        _bannerView.autoScrollTimeInterval = 2;
        
        //是否自动滚动, 默认YES
        _bannerView.autoScroll = YES;
        
        //是否无限循环,默认YES: 滚动到第四张图就不再滚动了
        _bannerView.infiniteLoop = YES;
        
        //翻页的位置
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    }
    return _bannerView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        ;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColorFromRGB(0xf3f3f4);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isShow = NO;
    [self hideBackButton];
    [self.view addSubview:self.bannerView];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[LivingNormalCell class] forCellReuseIdentifier:@"LivingNormalCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.bannerView.mas_bottom).offset(12);
    }];
    
    /*
     *强制更新
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [JKRequest requestCheckVersionWithVersion:app_Version
                                         type:@"IOS"
                                      success:^(id responseObject) {
        NSString *backBool = responseObject[@"data"];
        if (backBool.boolValue) { //YES
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/cn/app/id1485189944?l=zh&ls=1"] options:[NSDictionary dictionary] completionHandler:^(BOOL success) {
                
            }];
        }else{ //NO
//            JK_HUD_YES(@"当前是最新版本");
            [self initTheData];
        }
    }
                                      failure:^(NSString *errorMessage, id responseObject) {
        JK_HUD_NO(errorMessage);
    }];
    */
    
    [self initTheData];
}

- (void)showCQ{
    if (!isShow) {
        [CQBlockAlertView alertWithButtonClickedBlock:^{
           //进入新的一页
            BRWebViewController *reportVC = [[BRWebViewController alloc] init];
            reportVC.hidesBottomBarWhenPushed = YES;
            reportVC.title = @"投资风险提示公告";
            reportVC.mType = WebTypeReport;
            [self.navigationController pushViewController:reportVC animated:YES];
        }];
        isShow = YES;
    }
}

- (void)initTheData{
    [JKRequest requestHomepageInfoWithSuccess:^(id responseObject) {
        NSArray *baiArray = responseObject[@"bai"];
        NSArray *qianArray = responseObject[@"qian"];
        NSArray *sanArray = responseObject[@"san"];
        NSArray *yiArray = responseObject[@"yi"];
        [self.dataArray addObject:[JKModelConvert dataModelWithClass:[LivingModel class] andSource:sanArray]];
        [self.dataArray addObject:[JKModelConvert dataModelWithClass:[LivingModel class] andSource:baiArray]];
        [self.dataArray addObject:[JKModelConvert dataModelWithClass:[LivingModel class] andSource:qianArray]];
        [self.dataArray addObject:[JKModelConvert dataModelWithClass:[LivingModel class] andSource:yiArray]];
        [self.tableView reloadData];
        [self showCQ];
    } failure:^(NSString *errorMessage,id responseObject) {
        JK_HUD_NO(errorMessage);
    }];
    
    [JKRequest requestHomeBannerListWithSuccess:^(id responseObject) {
        NSArray *array = responseObject[@"data"];
        [self.bannerArray addObjectsFromArray:[JKModelConvert dataModelWithClass:[BannerModel class] andSource:array]];
        if (self.bannerArray.count < 1) {
            return ;
        }
        NSMutableArray *imagesURLStrings = [NSMutableArray new];
        for (BannerModel *model in self.bannerArray) {
            [imagesURLStrings addObject:model.thumbnail];
        }
        //采用网络图片
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.bannerView.imageURLStringsGroup = imagesURLStrings;
            });
    }
                                        failure:^(NSString *errorMessage, id responseObject) {
        JK_HUD_NO(errorMessage);
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
    return 195*mulNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *items = [self.dataArray objectAtIndex:indexPath.row];
    LivingNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LivingNormalCell"];
    [cell loadTheCellWith:(LivingModel *)items.firstObject];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *items = [self.dataArray objectAtIndex:indexPath.row];
    MyMember *member = [MyMember readFromFile];
    if (member.vipLevel.intValue > indexPath.row) { //该视频
        LinvingInfoViewController  *infoVC = [[LinvingInfoViewController alloc] init];
        infoVC.title = @"详情";
        infoVC.hidesBottomBarWhenPushed = YES;
        infoVC.items = items;
        [self.navigationController pushViewController:infoVC animated:YES];
    }else{ //宣传动画
        LivingAdvertiseViewController  *infoVC = [[LivingAdvertiseViewController alloc] init];
        infoVC.title = @"宣传动画";
        infoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infoVC animated:YES];
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    /** 轮播图点击事件
     */
    if (index == 0) {
        LivingBrokersViewController *brokers = [[LivingBrokersViewController alloc] init];
        brokers.title = @"券商列表";
        brokers.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:brokers animated:YES];
    }else if (index == 1){
        StockListController *stocks = [[StockListController alloc] init];
        stocks.title = @"最新视频";
        stocks.hidesBottomBarWhenPushed = YES;
        stocks.type = @"888";//最新视频列表
        [self.navigationController pushViewController:stocks animated:YES];
    }
}

@end
