//
//  MineCardListViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/6.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineCardListViewController.h"

#import "MineCardAddViewController.h"

#import "MineCardListCell.h"

#import "MineCardImageView.h"

#import "BankCardModel.h"

@interface MineCardListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *cardsTable;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MineCardListViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (UITableView *)cardsTable{
    if (!_cardsTable) {
        _cardsTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _cardsTable.delegate = self;
        _cardsTable.dataSource = self;
        _cardsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _cardsTable;
}

- (void)initTheData{
    UserInfoModel *model = [UserInfoModel readFromFile];
    [JKRequest requestBRMoneyCardList:model.user_id
                              success:^(id responseObject) {
                                  [self.dataArray removeAllObjects];
                                  [self.dataArray addObjectsFromArray:(NSArray *)responseObject];
                                  [self.cardsTable reloadData];
                              }
                              failure:^(NSString *errorMessage,id responseObject) {
                                  JK_HUD_NO(errorMessage);
                              }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.cardsTable];
    [self.cardsTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self.cardsTable registerClass:[MineCardListCell class] forCellReuseIdentifier:@"MineCardListCell"];
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor whiteColor];
    footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    self.cardsTable.tableFooterView = footerView;
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn addTarget:self action:@selector(handleAdd) forControlEvents:UIControlEventTouchUpInside];
    addBtn.titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:15];
    [addBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.backgroundColor = RGBCOLOR(255, 52, 58);
    [footerView addSubview:addBtn];
    addBtn.frame = CGRectMake(16, 20, SCREEN_WIDTH-32, 40);
    
    [self initTheData];
}

- (void)handleAdd{
    __weak typeof(self) weakSelf = self;
    MineCardAddViewController *addVC = [[MineCardAddViewController alloc] init];
    addVC.title = @"添加银行卡";
    addVC.backBlock = ^{
        [weakSelf initTheData];
    };
    [self.navigationController pushViewController:addVC animated:YES];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//单元格返回的编辑风格，包括删除 添加 和 默认  和不可编辑三种风格
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@""
                                                         message:@"是否删除该条记录"
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确定", nil];
        alert.tag = indexPath.row;
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != 0){
        BankCardModel *model = [self.dataArray objectAtIndex:alertView.tag];
        [JKRequest requestMoneyCardDelete: model.card_id
                                  success:^(id responseObject) {
                                      [self initTheData];
                                  }
                                  failure:^(NSString *errorMessage,id responseObject) {
                                      JK_HUD_NO(errorMessage);
                                  }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CARDHEIGHT+10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCardListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCardListCell"];
    [cell loadTheListCellWith:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BankCardModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (self.backData) {
        self.backData(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
    return;
}

@end
