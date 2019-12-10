//
//  PayResultViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/11/27.
//  Copyright © 2019 cy. All rights reserved.
//

#import "PayResultViewController.h"

#import "PayResultCell.h"
#import "PayResultNormalCell.h"
#import "PayModel.h"
#import "MyMember.h"

@interface PayResultViewController ()<UITableViewDelegate,UITableViewDataSource>{
    /**
     运行了几次
     */
    NSInteger timeCount;
    /**
     在3次内是否成功
     */
    BOOL   success;
}

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)dispatch_source_t  gcdPayTimer;

@property (nonatomic,strong)PayModel   *backItem;

@end

@implementation PayResultViewController


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorFromRGB(0xf3f3f4);
    }
    return _tableView;
}

- (void)initTheView{
    JK_HUD_DISMISS;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self.tableView registerClass:[PayResultNormalCell class] forCellReuseIdentifier:@"PayResultNormalCell"];
    [self.tableView registerClass:[PayResultCell class] forCellReuseIdentifier:@"PayResultCell"];
}

- (void)initTheData{
    timeCount++;
    [JKRequest requestPaySearchOutTradeNo:[UserContext getOrderNumber]
                                  success:^(id responseObject) {
        /**
         如果返回成功，停止定时器
         如果返回失败，不停止
         */
        self.backItem = [JKModelConvert dataModelWithClass:[PayModel class] andSource:responseObject[@"data"]];
        if (self.backItem.orderStatus.intValue == 1) { //成功了
            dispatch_source_cancel(self.gcdPayTimer);
            self->success = YES;
            MyMember *member = [MyMember readFromFile];
            member.vipLevel = [BRTool getTheBackStrWithgradeStr:self.backItem.rechargeLevel isBackInt:YES];
            [member saveToFile];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"com.yunvision.updateLevel" object:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
               [self initTheView];
            });
        }else{
            if (self->timeCount >= 4) {
                dispatch_source_cancel(self.gcdPayTimer);
                self->success = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                   [self initTheView];
                });
            }
        }
    }
                                  failure:^(NSString *errorMessage, id responseObject) {
        NSLog(@"查询失败了");
        if (self->timeCount >= 4) {
            dispatch_source_cancel(self.gcdPayTimer);
            self->success = NO;
            dispatch_async(dispatch_get_main_queue(), ^{
               [self initTheView];
            });
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    timeCount = 1;
    success = NO;
    
    JK_HUD_SHOW;
    __weak typeof(self) weakSelf = self;
    //创建GCD定时器
    _gcdPayTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
        //设置定时器
    dispatch_source_set_timer(_gcdPayTimer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0);
        //设置定时器任务
    dispatch_source_set_event_handler(_gcdPayTimer, ^{
        [weakSelf initTheData];
    });
        // 启动任务，GCD计时器创建后需要手动启动
    dispatch_resume(_gcdPayTimer);
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001f;
    }else{
        return 8;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = UIColorFromRGB(0xf3f3f4);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 110;
    }else{
        if (indexPath.row == 0 || indexPath.row == 2) {
            return 45.5;
        }else{
            return 105.5;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PayResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayResultCell"];
        [cell loadTheCellWithResult:success];
        return cell;
    }else{
        PayResultNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayResultNormalCell"];
        if (indexPath.row == 0) {
            [cell loadTheCellWith:[NSString stringWithFormat:@"充值会员：%@",[BRTool getTheBackStrWithgradeStr:self.backItem.rechargeLevel isBackInt:NO]]];
        }else if (indexPath.row == 1){
            [cell loadTheCellWith:[NSString stringWithFormat:@"订单编号：%@",self.backItem.outTradeNo]
                         content1:[NSString stringWithFormat:@"订单金额：%@元",self.backItem.totalPrice]
                         content2:[NSString stringWithFormat:@"%@：%@",self.backItem.payChannel.intValue==10?@"支付宝交易号":@"微信交易号",self.backItem.tradeNo.length>0?self.backItem.tradeNo:@""]];
        }else{
            [cell loadTheCellWith:[NSString stringWithFormat:@"创建时间：%@",self.backItem.orderDate]];
        }
        return cell;
    }
}

@end
