//
//  LivingAdvertiseViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/10/8.
//  Copyright © 2019 cy. All rights reserved.
//

#import "LivingAdvertiseViewController.h"
#import "AppDelegate.h"
#import "JWPlayer.h"

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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
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
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(TopStatus);
        make.left.equalTo(self.view).offset(5);
        make.height.width.mas_equalTo(44);
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
