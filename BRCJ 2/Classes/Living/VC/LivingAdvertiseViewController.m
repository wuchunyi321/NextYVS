//
//  LivingAdvertiseViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/10/8.
//  Copyright © 2019 cy. All rights reserved.
//

#import "LivingAdvertiseViewController.h"
#import "JWPlayer.h"

#import "CQBlockAlertView.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import "WXApiRequestHandler.h"
//#import "WXApi.h"

#define videoUrl (@"https://black-horse-club.oss-cn-hangzhou.aliyuncs.com/xuanchuanshipin/yvs-xcsp.mp4")

@interface LivingAdvertiseViewController ()<JWPlayerDelegate>
{
    UIButton *backBtn; //返回按钮
}

@property (nonatomic,strong)JWPlayer*player;

@end

@implementation LivingAdvertiseViewController

- (JWPlayer *)player{
    if (!_player) {
        _player=[[JWPlayer alloc]initWithFrame:CGRectMake(0, TopStatus, SCREEN_WIDTH,200)];
        _player.delegate = self;
    }
    return _player;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"com.yunvision.Rotation" object:[NSNumber numberWithBool:YES]];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)playerTransfer:(JWPlayer *)player withIsLandscape:(NSNumber *)landscape{
    BOOL isLandS = landscape.boolValue;
    if (isLandS) { //横屏
        backBtn.hidden = YES;
    }else{
        backBtn.hidden = NO;
    }
}

- (void)back:(id)sender{
    //这个地方要处理一下，如果视频准备播放，就停止
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
    [backBtn setImage:[UIImage imageNamed:@"BRSource.bundle/nav_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(TopStatus);
        make.left.equalTo(self.view).offset(5);
        make.height.width.mas_equalTo(44);
    }];
}


//- (void)doAPPayWithPrice:(NSString *)price{
//    NSString *appScheme = @"BRCJ";
//    [[AlipaySDK defaultService] payOrder:price fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//        NSLog(@"reslut = %@",resultDic);
//    }];
//}

/**
 播放完成
 */
- (void)playFinished{
    MyMember *member = [MyMember readFromFile];
    UserInfoModel *user = [UserInfoModel readFromFile];
    __weak typeof(self) weakSelf = self;
    [CQBlockAlertView alertShowWithType:weakSelf.vipType
                            VXBackBlock:^{ //微信支付
        if ([TransferDataTool isWXAppInstalled]) {
            [JKRequest requestPayWithVXRechargeLevel:[BRTool getTheGradeStrWith:weakSelf.vipType]
                                            userId:member.userId
                                             grade:member.vipLevel
                                            mobile:user.mobile
                                           success:^(id responseObject) {
                NSDictionary *data = responseObject[@"data"];
                NSString *orderNumber = responseObject[@"order"][@"outTradeNo"];
                [UserContext setOrderNumber:orderNumber];
//                [WXApiRequestHandler jumpToBizPayWithStr:data];
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
                [JKRequest requestPayWithRechargeLevel:[BRTool getTheGradeStrWith:weakSelf.vipType]
                                                userId:member.userId
                                                 grade:member.vipLevel
                                                mobile:user.mobile
                                               success:^(id responseObject) {
                    NSString *data = responseObject[@"data"];
                    NSString *orderNumber = responseObject[@"order"][@"outTradeNo"];
                    [UserContext setOrderNumber:orderNumber];
//                   [weakSelf doAPPayWithPrice:data];
                    [TransferDataTool zfbPayWith:data];
                }
                                               failure:^(NSString *errorMessage, id responseObject) {
                    NSLog(@"订单信息获取失败");
                }];
    }];
}

//界面方向改变的处理
- (void)position: (NSNotification *)notification{
    [self.player rotationChanged:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(position:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
    [self initTheView];
    [self.player updatePlayerWith:[NSURL URLWithString:videoUrl]];
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
