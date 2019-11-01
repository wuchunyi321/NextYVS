//
//  StockViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import "StockViewController.h"

#import "StockListController.h"

#import "StockImageView.h"
#import "StockBlockView.h"

#define UP_STOCK_WIDTH          98*mulNumber
#define UP_STOCK_HEIGHT         98*mulNumber

#define DOWN_STOCK_WIDTH         152*mulNumber
#define DOWN_STOCK_HEIGHT        125*mulNumber

@interface StockViewController ()<StockImageViewDelegate>

@property (nonatomic,strong)UIView  *headerBgView;

/** 深圳指数 **/
@property (nonatomic,strong)StockBlockView *s_stockView;
@property (nonatomic,copy)NSString  *she_Str;

/** 上证指数 **/
@property (nonatomic,strong)StockBlockView *h_stockView;
@property (nonatomic,copy)NSString  *sha_Str;
/** 创业板 **/
@property (nonatomic,strong)StockBlockView *c_stockView;
@property (nonatomic,copy)NSString  *chu_Str;

@property (nonatomic,strong)dispatch_source_t  gcdTimer;

@end

@implementation StockViewController


- (StockBlockView *)s_stockView{
    if (!_s_stockView) {
        _s_stockView = [[StockBlockView alloc] init];
        _s_stockView.backgroundColor = [UIColor whiteColor];
    }
    return _s_stockView;
}

- (StockBlockView *)h_stockView{
    if (!_h_stockView) {
        _h_stockView = [[StockBlockView alloc] init];
        _h_stockView.backgroundColor = [UIColor whiteColor];
    }
    return _h_stockView;
}

- (StockBlockView *)c_stockView{
    if (!_c_stockView) {
        _c_stockView = [[StockBlockView alloc] init];
         _c_stockView.backgroundColor = [UIColor whiteColor];
    }
    return _c_stockView;
}

- (UIView *)headerBgView{
    if (!_headerBgView) {
        _headerBgView = [[UIView alloc] initWithFrame:CGRectMake(10, TopHeight+10, SCREEN_WIDTH-20, 120*mulNumber)];
        _headerBgView.layer.cornerRadius = 8;
        _headerBgView.backgroundColor = [UIColor whiteColor];
    }
    return _headerBgView;
}

- (void)initTheView{
    /** 上部分 **/
    [self.view addSubview:self.headerBgView];
    
    [self.headerBgView addSubview:self.h_stockView];
    [self.h_stockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerBgView).offset(10);
        make.centerY.equalTo(self.headerBgView);
        make.width.mas_equalTo(UP_STOCK_WIDTH);
        make.height.mas_equalTo(UP_STOCK_HEIGHT);
    }];
    
    [self.headerBgView addSubview:self.s_stockView];
    [self.s_stockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.headerBgView);
        make.width.mas_equalTo(UP_STOCK_WIDTH);
        make.height.mas_equalTo(UP_STOCK_HEIGHT);
    }];
    
    [self.headerBgView addSubview:self.c_stockView];
    [self.c_stockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headerBgView).offset(-10);
        make.centerY.equalTo(self.headerBgView);
        make.width.mas_equalTo(UP_STOCK_WIDTH);
        make.height.mas_equalTo(UP_STOCK_HEIGHT);
    }];
    [self.s_stockView setWidget];
    [self.h_stockView setWidget];
    [self.c_stockView setWidget];
    
    /**
     下部分
     */
    UIView *downBgView = [UIView new];
    downBgView.backgroundColor = [UIColor whiteColor];
    downBgView.layer.cornerRadius = 8;
    [self.view addSubview:downBgView];
    
    CGFloat leftHeight = SCREEN_HEIGHT - TopHeight -BottomStatus - 120*mulNumber - 20 - (DOWN_STOCK_HEIGHT+64)*2;
    [downBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.headerBgView.mas_bottom).offset(leftHeight/2.0);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo((DOWN_STOCK_HEIGHT+64)*2);
    }];
    
    for (int i = 0; i<4; i++) {
        if (i/2 == 0) { //第一行
            StockImageView *imageView = [[StockImageView alloc] init];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i+555;
            imageView.delegate = self;
            [downBgView addSubview:imageView];
            imageView.image = [UIImage imageNamed:[self imageName:i]];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(downBgView).offset(20+(DOWN_STOCK_HEIGHT+64)*(i%2));
                make.width.mas_equalTo(DOWN_STOCK_WIDTH);
                make.height.mas_equalTo(DOWN_STOCK_HEIGHT);
                make.left.equalTo(downBgView).offset(10);
            }];
            
            UILabel *titleLabel = [UILabel new];
            titleLabel.text = [self imageNameWith:i];
            titleLabel.textColor = RGBCOLOR(42, 42, 42);
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:12];
            [downBgView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) { make.top.equalTo(downBgView).offset(20+(DOWN_STOCK_HEIGHT+64)*(i%2)+DOWN_STOCK_HEIGHT+15);
                make.width.mas_equalTo(DOWN_STOCK_WIDTH);
                make.height.mas_equalTo(12);
                make.left.equalTo(downBgView).offset(10);
            }];
        }else{ //第二行
             StockImageView *imageView = [[StockImageView alloc] init];
             imageView.userInteractionEnabled = YES;
             imageView.tag = i+555;
             imageView.delegate = self;
             [downBgView addSubview:imageView];
             imageView.image = [UIImage imageNamed:[self imageName:i]];
             [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.top.equalTo(downBgView).offset(20+(DOWN_STOCK_HEIGHT+64)*(i%2));
                 make.width.mas_equalTo(DOWN_STOCK_WIDTH);
                 make.height.mas_equalTo(DOWN_STOCK_HEIGHT);
                 make.right.equalTo(downBgView).offset(-10);
             }];
             
             UILabel *titleLabel = [UILabel new];
             titleLabel.text = [self imageNameWith:i];
             titleLabel.textColor = RGBCOLOR(42, 42, 42);
             titleLabel.textAlignment = NSTextAlignmentLeft;
             titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:12];
             [downBgView addSubview:titleLabel];
             [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) { make.top.equalTo(downBgView).offset(20+(DOWN_STOCK_HEIGHT+64)*(i%2)+DOWN_STOCK_HEIGHT+15);
                 make.width.mas_equalTo(DOWN_STOCK_WIDTH);
                 make.height.mas_equalTo(12);
                 make.right.equalTo(downBgView).offset(-10);
             }];
        }
    }
}

- (void)viewClicked:(StockImageView *)imageView{
    NSLog(@"index === %ld",(long)imageView.tag);
    NSInteger index = imageView.tag-554;
    if (index == 2) {
        index = 3;
    }else if(index == 3)
        index = 2;
    
    StockListController *listVC = [[StockListController alloc] init];
    listVC.title = [self imageNameWith:imageView.tag-555];
//    listVC.type = [NSString stringWithFormat:@"%ld",(long)imageView.tag-554];
    listVC.type = [NSString stringWithFormat:@"%ld",(long)index];
    listVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVC animated:YES];
}

- (NSString *)imageNameWith:(NSInteger)i{
    NSString *backStr = @"实盘讲解";
    if (i == 0) {
        backStr = @"实盘讲解";
    }else if (i == 1){
        backStr = @"波段为王";
    }else if (i == 2){
        backStr = @"热点捕捉";
    }else{
        backStr = @"长线是金";
    }
    return backStr;
}

- (NSString *)imageName:(NSInteger)index{
    NSString *name = @"stock_shi";
    if (index == 0) {
        name = @"stock_shi";
    }else if (index == 1){
        name = @"stock_bo";
    }else if (index == 2){
        name = @"stock_re";
    }else{
        name = @"stock_chang";
    }
    return name;
}

- (void)initTheData{
    [JKRequest requestWithStr:BRRongStock_she
                      success:^(id responseObject) {
                          NSString *backStr = (NSString *)responseObject;
                          NSString *regTags = @"[\"']?([^>'\"]+)[\"']?";      // 设计好的正则表达式
                          NSError  *error_x = nil;
                          NSRegularExpression *regex_x = [NSRegularExpression regularExpressionWithPattern:regTags options:NSRegularExpressionCaseInsensitive   error:&error_x];
                          // 执行匹配的过程
                          NSArray *matches_x = [regex_x matchesInString:backStr options:0 range:NSMakeRange(0, backStr.length)];
                          // 用下面的办法来遍历每一条匹配记录
                          for (NSTextCheckingResult *match in matches_x){
                              NSRange matchRange = [match range];
                              NSString *tagString = [backStr substringWithRange:matchRange];  // 整个匹配串
                              if ([tagString hasPrefix:@"深证成指"]) {
                                  self.she_Str = tagString;
                                  break;
                              }
                          }
                            dispatch_async(dispatch_get_main_queue(), ^{
                               [self.s_stockView loadTheShangwith:self.she_Str];
                            });
                      }
                      failure:^(NSString *errorMessage,id responseObject) {
                          JK_HUD_NO(errorMessage);
                      }];
    
    [JKRequest requestWithStr:BRRongStock_sha
                      success:^(id responseObject) {
                          NSString *backStr = (NSString *)responseObject;
                          NSString *regTags = @"[\"']?([^>'\"]+)[\"']?";      // 设计好的正则表达式
                          NSError  *error_x = nil;
                          NSRegularExpression *regex_x = [NSRegularExpression regularExpressionWithPattern:regTags options:NSRegularExpressionCaseInsensitive   error:&error_x];
                          // 执行匹配的过程
                          NSArray *matches_x = [regex_x matchesInString:backStr options:0 range:NSMakeRange(0, backStr.length)];
                          // 用下面的办法来遍历每一条匹配记录
                          for (NSTextCheckingResult *match in matches_x){
                              NSRange matchRange = [match range];
                              NSString *tagString = [backStr substringWithRange:matchRange];  // 整个匹配串
                              if ([tagString hasPrefix:@"上证指数"]) {
                                  self.sha_Str = tagString;
                                  break;
                              }
                          }
                        dispatch_async(dispatch_get_main_queue(), ^{
                           [self.h_stockView loadTheShangwith:self.sha_Str];
                        });
                      }
                      failure:^(NSString *errorMessage,id responseObject) {
                          JK_HUD_NO(errorMessage);
                      }];
    
    [JKRequest requestWithStr:BRRongStock_chu
                      success:^(id responseObject) {
                          NSString *backStr = (NSString *)responseObject;
                          NSString *regTags = @"[\"']?([^>'\"]+)[\"']?";      // 设计好的正则表达式
                          NSError  *error_x = nil;
                          NSRegularExpression *regex_x = [NSRegularExpression regularExpressionWithPattern:regTags options:NSRegularExpressionCaseInsensitive   error:&error_x];
                          // 执行匹配的过程
                          NSArray *matches_x = [regex_x matchesInString:backStr options:0 range:NSMakeRange(0, backStr.length)];
                          // 用下面的办法来遍历每一条匹配记录
                          for (NSTextCheckingResult *match in matches_x){
                              NSRange matchRange = [match range];
                              NSString *tagString = [backStr substringWithRange:matchRange];  // 整个匹配串
                              if ([tagString hasPrefix:@"创业板指"]) {
                                  self.chu_Str = tagString;
                                  break;
                              }
                          }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.c_stockView loadTheShangwith:self.chu_Str];
                        });
                      }
                      failure:^(NSString *errorMessage,id responseObject) {
                          JK_HUD_NO(errorMessage);
                      }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideBackButton];
    // Do any additional setup after loading the view.
    [self initTheView];
    
    __weak typeof(self) weakSelf = self;
    //创建GCD定时器
    _gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
        //设置定时器
    dispatch_source_set_timer(_gcdTimer, dispatch_walltime(NULL, 0), 3 * NSEC_PER_SEC, 0);
        //设置定时器任务
    dispatch_source_set_event_handler(_gcdTimer, ^{
        [weakSelf initTheData];
    });
        // 启动任务，GCD计时器创建后需要手动启动
    dispatch_resume(_gcdTimer);
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

