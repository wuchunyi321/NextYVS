//
//  MineFriendListViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/6.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineFriendListViewController.h"

#import "MineFriendsCell.h"

#import "FriendsModel.h"

#import "JKNoneDataView.h"

@interface MineFriendListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *friendsTable;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)JKNoneDataView *noneDataView;

@end

@implementation MineFriendListViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (UITableView *)friendsTable{
    if (!_friendsTable) {
        _friendsTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _friendsTable.delegate = self;
        _friendsTable.dataSource = self;
        _friendsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _friendsTable.backgroundColor = UIColorFromRGB(0xf5f5f5);
        _friendsTable.showsHorizontalScrollIndicator = NO;
        _friendsTable.showsVerticalScrollIndicator = NO;
    }
    return _friendsTable;
}

- (void)initTheView{
    [self.view addSubview:self.friendsTable];
    [self.friendsTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self.friendsTable registerClass:[MineFriendsCell class] forCellReuseIdentifier:@"MineFriendsCell"];
}

- (void)initTheData{
    [JKRequest requestFriendsListWithPage:@1
                                 pageSize:@20
                                     type:@1
                                  success:^(id responseObject) {
                                      if ([self.detailType isEqualToString:@"云友"]) {
                                          [self.dataArray removeAllObjects];
                                          NSArray *array = [JKModelConvert dataModelWithClass:[FriendsModel class] andSource:responseObject[@"miyou"]];
                                          [self.dataArray addObjectsFromArray:array];
                                      }else if ([self.detailType isEqualToString:@"视友"]){
                                          [self.dataArray removeAllObjects];
                                          NSArray *array = [JKModelConvert dataModelWithClass:[FriendsModel class] andSource:responseObject[@"kayou"]];
                                          [self.dataArray addObjectsFromArray:array];
                                      }else{
                                          [self.dataArray removeAllObjects];
                                          NSArray *array = [JKModelConvert dataModelWithClass:[FriendsModel class] andSource:responseObject[@"moyou"]];
                                          [self.dataArray addObjectsFromArray:array];
                                      }
                                      [self.noneDataView setHidden:self.dataArray.count > 0];
                                      [self.friendsTable reloadData];
                                  }
                                  failure:^(NSString *errorMessage,id responseObject) {
                                      JK_HUD_NO(errorMessage);
                                  }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineFriendsCell"];
    [cell loadTheCellWith:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


#pragma mark - noneDataView
-(JKNoneDataView *)noneDataView{
    if (!_noneDataView) {
        _noneDataView =[JKNoneDataView initNoneDataViewWithFrame:self.friendsTable.bounds type:@"暂无数据"];
        [self.friendsTable addSubview:_noneDataView];
        _noneDataView.hidden =YES;
    }
    return _noneDataView;
}

@end
