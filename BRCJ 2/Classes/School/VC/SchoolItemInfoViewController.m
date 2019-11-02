//
//  SchoolItemInfoViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/1.
//  Copyright © 2019 cy. All rights reserved.
//

#import "SchoolItemInfoViewController.h"
#import "SchoolListItem.h"
#import "StockModel.h"
#import "AnchorModel.h"

#import "SchoolAuthorCell.h"
/*** 视频简介 **/
#import "SchoolHeaderView.h"

//#import "AppDelegate.h"
#import "JWPlayer.h"

#import "SchoolInfoViewController.h"

@interface SchoolItemInfoViewController ()
<UITableViewDelegate,
UITableViewDataSource,
JWPlayerDelegate,
SchoolInfoViewControllerDelegate>{
    NSInteger pageIndex;
    UIButton *backBtn; //返回按钮
    SchoolHeaderView  *headerView;
}

@property (nonatomic,strong)JWPlayer*player;

@property (nonatomic,strong)UILabel                *titleLabel;
@property (nonatomic,strong)UILabel                *subTitle;



@property (nonatomic,strong)NSMutableArray         *dataArray;

@property (nonatomic,strong)UITableView  *tableView;

@property (nonatomic,strong)AnchorModel  *anchorItem;

@end

@implementation SchoolItemInfoViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


- (void)playerTransfer:(JWPlayer *)player withIsLandscape:(NSNumber *)landscape{
    BOOL isLandS = landscape.boolValue;
    if (isLandS) { //横屏
        backBtn.hidden = YES;
        self.tableView.hidden = YES;
    }else{
        backBtn.hidden = NO;
        self.tableView.hidden = NO;
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (JWPlayer *)player{
    if (!_player) {
        _player=[[JWPlayer alloc]initWithFrame:CGRectMake(0, TopStatus, SCREEN_WIDTH,200)];
        _player.delegate = self;
    }
    return _player;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    appDelegate.allowRotation = YES;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)back:(id)sender{
    if (self.player.isLandscape) { //横屏
        
    }else{
        [self.player pause];
        self.player = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)initTheView{
    
    [self.view addSubview:self.player];
    
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(TopStatus);
        make.left.equalTo(self.view).offset(5);
        make.height.width.mas_equalTo(44);
    }];
    
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.player.mas_bottom);
        }];
        [self.tableView registerClass:[SchoolAuthorCell class] forCellReuseIdentifier:@"SchoolAuthorCell"];
    
    /** 这个地方要变化一下 **/
    headerView = [[SchoolHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    [headerView loadTheHeaderViewWithTitle:(self.type == 1 || self.type == 3)?self.sotckItem.shareTitle : self.model.videoTitle
                                    detail:(self.type == 1 || self.type == 3)? self.sotckItem.introduction: self.model.introduction];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
}

- (void)dealloc{
    self.player = nil;
}

- (void)initTheData{
    [JKRequest requestSchoolEspeciallyPageNumber:@"1"
                                        PageSize:@"1"
                                        AnchorId:(self.type == 1 || self.type == 3) ?self.sotckItem.anchorId:self.model.anchorId
                                         success:^(id responseObject) {
        
                                             self.anchorItem = [JKModelConvert dataModelWithClass:[AnchorModel class] andSource:responseObject[@"anchor"]];
                                             [self.dataArray addObject:self.anchorItem];
                                             [self.tableView reloadData];
                                         }
                                         failure:^(NSString *errorMessage,id responseObject) {
                                             JK_HUD_NO(errorMessage);
                                         }];
}

//界面方向改变的处理
- (void)position: (NSNotification *)notification{
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (interfaceOrientation) {
        case UIInterfaceOrientationUnknown:
            NSLog(@"未知方向");
            break;
        case UIInterfaceOrientationPortrait:
            NSLog(@"界面直立");
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            NSLog(@"界面直立，上下颠倒");
            break;
        case UIInterfaceOrientationLandscapeLeft:
            {
                NSLog(@"界面左横");
//                [self disMissListVC];
            }
            break;
        case UIInterfaceOrientationLandscapeRight:
            {
                NSLog(@"界面画右恒");
//                [self disMissListVC];
            }
            break;
        default:
            break;
    }
    
    [self.player rotationChanged:nil];
}

- (void)initTheCheckWithType:(NSString *)type AndId:(NSString *)itemId{
    [JKRequest requestSchoolcheckWithType:type
                               materialId:itemId
                                  success:^(id responseObject) {
        NSLog(@"统计正常");
    }
                                  failure:^(NSString *errorMessage, id responseObject) {
        NSLog(@"失败");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *typeStr = @"shares";
    if (self.type == 1) {
        typeStr = @"shares";
    }else if (self.type == 2){
        typeStr = @"school";
    }else{
        typeStr = @"newvideos";
    }
    
    [self initTheCheckWithType:typeStr
                         AndId:(self.type == 1 || self.type == 3) ?self.sotckItem.stock_id:self.model.item_id];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(position:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
    pageIndex = 1;
    // Do any additional setup after loading the view.
    [self initTheView];
    if (self.type == 1 || self.type == 3) {
        [self.player updatePlayerWith:[NSURL URLWithString:self.sotckItem.videoUrl]];
    }else{
        [self.player updatePlayerWith:[NSURL URLWithString:self.model.videoUrl]];
    }
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count>0?1:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SchoolAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchoolAuthorCell"];
    [cell loadTheCellWith:[self.dataArray objectAtIndex:indexPath.row] avatar:self.anchorItem.headPortrait];
    return cell;
}

- (void)chooseItemWithUrl:(id)item{
    NSString *videoUrl = nil;
    if (self.type == 1 || self.type == 3) {
        videoUrl = ((StockModel *)item).videoUrl;
    }else{
        videoUrl = ((SchoolListItem *)item).videoUrl;
    }
    [self initTheCheckWithType:self.type == 1?@"shares":(self.type == 2?@"school":@"newvideos") AndId:(self.type == 1 || self.type == 3) ?((StockModel *)item).stock_id:((SchoolListItem *)item).item_id];
    [self.player updatePlayerWith:[NSURL URLWithString:videoUrl]];
    [headerView loadTheHeaderViewWithTitle:(self.type == 1 || self.type == 3)?((StockModel *)item).shareTitle : ((SchoolListItem *)item).videoTitle
                                    detail:(self.type == 1 || self.type == 3)? ((StockModel *)item).introduction: ((SchoolListItem *)item).introduction];
    self.tableView.tableHeaderView = headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /**
     这里进行操作弹出另外一个VC
     */
    SchoolInfoViewController  *infoVC = [[SchoolInfoViewController alloc] init];
    infoVC.anchorItem = [self.dataArray objectAtIndex:indexPath.row];
    infoVC.delegate = self;
    infoVC.type = self.type; //这个地方需要注意一下 ********************************
    [self.navigationController pushViewController:infoVC animated:YES];
}

@end
