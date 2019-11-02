//
//  MineSetViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/5.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineSetViewController.h"

#import "MineInfoNormalCell.h"

//#import "AppDelegate+RootVC.h" //切换登录状态

@interface MineSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MineSetViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MineInfoNormalCell class] forCellReuseIdentifier:@"MineInfoNormalCell"];
    
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 210);
    headerView.backgroundColor = [UIColor whiteColor];
    UIImageView *logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"set_logo"]];
    logoImage.frame = CGRectMake((SCREEN_WIDTH-84)/2, 30, 84, 84);
    logoImage.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    logoImage.layer.shadowOffset = CGSizeZero;
    logoImage.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    logoImage.layer.shadowRadius = 3;//阴影半径，默认3
    [headerView addSubview:logoImage];
    
    UILabel *versionLabel = [UILabel new];
    versionLabel.text = @"云视界科技1.0.0";
    versionLabel.textColor = RGBCOLOR(108, 108, 108);
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.frame = CGRectMake(0, 30+84+20, SCREEN_WIDTH, 13);
    [headerView addSubview:versionLabel];
    
    self.tableView.tableHeaderView = headerView;
    
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor whiteColor];
    footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
    
    UIButton *loginoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginoutBtn addTarget:self action:@selector(handleLoginOut) forControlEvents:UIControlEventTouchUpInside];
    [loginoutBtn setTitle:@"退出" forState:UIControlStateNormal];
    [loginoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginoutBtn.titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:15];
    loginoutBtn.backgroundColor = RGBCOLOR(255, 52, 58);
    loginoutBtn.frame = CGRectMake(15, 40, SCREEN_WIDTH-30, 44);
    [footerView addSubview:loginoutBtn];
    self.tableView.tableFooterView = footerView;
}

- (void)handleLoginOut{
//    [UserContext clearLogin];
//    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [delegate setLoginViewController];
//    [delegate deleteAlias];
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
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineInfoNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineInfoNormalCell"];
    [cell loadTheCellWithType:indexPath.row ==0?MineInfoNormalCellTypeClear:MineInfoNormalCellTypeVersionUpdate value:@""];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) { //清除缓存
        
    }else{ //版本更新
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
                JK_HUD_YES(@"当前是最新版本");
            }
        }
                                          failure:^(NSString *errorMessage, id responseObject) {
            JK_HUD_NO(errorMessage);
        }];
    }
    return;
}



@end
