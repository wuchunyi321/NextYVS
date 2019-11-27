//
//  MineViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/30.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineViewController.h"

#import "MineHomeTableCell.h"
#import "MineHomeHeaderCell.h"
/**邀请 **/
#import "MineInviteViewController.h"
/** 关于我们 && 免责声明 **/
#import "BRWebViewController.h"
/** 我的好友 **/
#import "MineFriendsViewController.h"
/**设置 **/
#import "MineSetViewController.h"
/**个人信息 **/
#import "MineInfoViewController.h"
/** 消息列表 **/
#import "MineMessageViewController.h"
/**
 订单列表
 */
#import "MainPayListViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,MineInfoViewControllerDelegate>{
    UIButton *rightBtn;
}

@property (nonatomic,strong)UITableView *mineTable;

@end

@implementation MineViewController

- (UITableView *)mineTable{
    if (!_mineTable) {
        _mineTable = [[UITableView alloc] init];
        _mineTable.delegate = self;
        _mineTable.dataSource = self;
        _mineTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mineTable.backgroundColor = UIColorFromRGB(0xf5f5f5);
    }
    return _mineTable;
}

- (void)initTheView{
    [self.view addSubview:self.mineTable];
    [self.mineTable registerClass:[MineHomeTableCell class] forCellReuseIdentifier:@"MineHomeTableCell"];
    [self.mineTable registerClass:[MineHomeHeaderCell class] forCellReuseIdentifier:@"MineHomeHeaderCell"];
    [self.mineTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

- (void)tapNaviRightButton{
    MineMessageViewController *messageVC = [[MineMessageViewController alloc] init];
    messageVC.title = @"消息";
    messageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideBackButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMyInfo) name:@"com.yunvision.updateLevel" object:nil];
    
    rightBtn = [[UIButton alloc] init];
    [rightBtn addTarget:self action:@selector(tapNaviRightButton) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.enabled = YES;
    [rightBtn setImage:[UIImage imageNamed:@"mine_message"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 12, 0, -12);
    rightBtn.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *RightbarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:RightbarButtonItem];
    
    // Do any additional setup after loading the view.
    [self initTheView];
}

#pragma mark --- UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 5;
    }else{
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 87;
    }else{
        return 44;
    }
}

- (MineHomeTableCellType)getTheTypeWith:(NSIndexPath *)indexPath{
    MineHomeTableCellType  type= MineHomeTableCellTypeSet;
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            type = MineHomeTableCellTypeInvate;
        }else if (indexPath.row == 2){
            type = MineHomeTableCellTypeAboutUs;
        }else if (indexPath.row == 3){
            type = MineHomeTableCellTypeReport;
        }else if (indexPath.row == 4){
            type = MineHomeTableCellTypePay;
        }else{
            type = MineHomeTableCellTypeMyFriends;
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            type = MineHomeTableCellTypeCallUs;
        }else{
            type = MineHomeTableCellTypeSet;
        }
    }
    return type;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MineHomeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineHomeHeaderCell"];
        UserInfoModel *user = [UserInfoModel readFromFile];
        [cell loadTheCellWithTitle:user.nickname andAvatar:user.headPortrait];
        return cell;
    }else{
        MineHomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineHomeTableCell"];
        [cell loadTheCellWithType:[self getTheTypeWith:indexPath]];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)updateMyInfo{
    [self.mineTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MineInfoViewController *infoVC = [[MineInfoViewController alloc] init];
        infoVC.hidesBottomBarWhenPushed = YES;
        infoVC.delegate = self;
        infoVC.title = @"我的信息";
        [self.navigationController pushViewController:infoVC animated:YES];
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            MineInviteViewController *inviteVC = [[MineInviteViewController alloc] init];
            inviteVC.hidesBottomBarWhenPushed = YES;
            inviteVC.title = @"邀请";
            [self.navigationController pushViewController:inviteVC animated:YES];
        }else if (indexPath.row == 2){
            BRWebViewController *aboutUsVC = [[BRWebViewController alloc] init];
            aboutUsVC.hidesBottomBarWhenPushed = YES;
            aboutUsVC.title = @"关于我们";
            aboutUsVC.mType = WebTypeAboutUs;
            [self.navigationController pushViewController:aboutUsVC animated:YES];
        }else if (indexPath.row == 3){
            BRWebViewController *reportVC = [[BRWebViewController alloc] init];
            reportVC.hidesBottomBarWhenPushed = YES;
            reportVC.title = @"免责声明";
            reportVC.mType = WebTypeDisclaimer;
            [self.navigationController pushViewController:reportVC animated:YES];
        }else if (indexPath.row == 4){ //订单列表
            MainPayListViewController *reportVC = [[MainPayListViewController alloc] init];
            reportVC.hidesBottomBarWhenPushed = YES;
            reportVC.title = @"订单列表";
            [self.navigationController pushViewController:reportVC animated:YES];
        }else if (indexPath.row == 1){
            MineFriendsViewController *friendsVC = [[MineFriendsViewController alloc] init];
            friendsVC.title = @"我的好友";
            friendsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:friendsVC animated:YES];
        }
    }else{
        if (indexPath.row == 0) {
            BRWebViewController *reportVC = [[BRWebViewController alloc] init];
            reportVC.hidesBottomBarWhenPushed = YES;
            reportVC.title = @"联系我们";
            reportVC.mType = WebTypeCallUs;
            [self.navigationController pushViewController:reportVC animated:YES];
        }else{
            MineSetViewController *setVC = [[MineSetViewController alloc] init];
            setVC.title = @"设置";
            setVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setVC animated:YES];
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
