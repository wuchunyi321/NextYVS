//
//  BRSwitchViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/5.
//  Copyright © 2019 cy. All rights reserved.
//

#import "BRSwitchViewController.h"

@interface BRSwitchViewController ()<UIScrollViewDelegate>{
    CGFloat tabWidth;
    NSInteger lastHighLightIndex;
}

@property (nonatomic,strong)UIScrollView *bgScrollView;

@property (nonatomic,strong)UIView       *titleView;

@property (nonatomic,strong)UIView       *lineView;
/** 数据 **/
@property (nonatomic,copy)NSArray        *dataArray;
/** 占位符 **/
@property (nonatomic,strong)NSMutableArray  *vcArray;

@end

@implementation BRSwitchViewController

- (NSMutableArray *)vcArray{
    if (!_vcArray) {
        _vcArray = [NSMutableArray new];
    }
    return _vcArray;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = RGBCOLOR(255, 50, 57);
    }
    return _lineView;
}

- (UIView *)titleView{
    if (!_titleView) {
        _titleView = [UIView new];
        _titleView.backgroundColor = RGBCOLOR(237, 235, 235);
    }
    return _titleView;
}

- (UIScrollView *)bgScrollView{
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] init];
        _bgScrollView.delegate = self;
//        _bgScrollView.backgroundColor = [UIColor yellowColor];
        _bgScrollView.pagingEnabled = YES;
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.bounces = NO;
    }
    return _bgScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lastHighLightIndex = -1;
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.bgScrollView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(36);
    }];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.titleView.mas_bottom);
    }];
}

/** 切换页面 **/
- (void)btnClicked:(UIButton *)btn{
    NSInteger selectedIndex = btn.tag-100;
    if (selectedIndex == lastHighLightIndex) {
        return;
    }
    [UIView beginAnimations:@"buttomAni" context:nil];
    CGFloat xOffset = tabWidth * (btn.tag - 100);
    [self.lineView setFrame:CGRectMake(xOffset, 34, tabWidth, 2)];
    self.bgScrollView.contentOffset = CGPointMake(SCREEN_WIDTH * (btn.tag -100), 0);
    [UIView commitAnimations];
    [self hightLightButton:selectedIndex];
}

/** 切换页面 **/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.bgScrollView.contentOffset.x < 0
        || (self.bgScrollView.contentOffset.x + self.bgScrollView.frame.size.width) > self.bgScrollView.contentSize.width) {
        return;
    }
    CGFloat xOffset = SCREEN_WIDTH * (self.bgScrollView.contentOffset.x / self.bgScrollView.contentSize.width);
    [UIView beginAnimations:@"buttomAni" context:nil];
    [self.lineView setFrame:CGRectMake(xOffset, 34, tabWidth, 2)];
    [UIView commitAnimations];
    NSInteger tabIndex = xOffset / tabWidth;
    if (tabIndex == lastHighLightIndex) {
        return;
    }
}

-(void)hightLightButton:(NSInteger)index{
    if (index == lastHighLightIndex){
        return;
    }
    UIButton *lastBtn = (UIButton *)[self.titleView viewWithTag:100+lastHighLightIndex];
    UIButton *nowBtn = (UIButton *)[self.titleView viewWithTag:100+index];
    lastBtn.selected = NO;
    lastBtn.titleLabel.font = [UserContext getTheFontWithName:@"PingFangSC-Regular" size:13];
    nowBtn.selected = YES;
    nowBtn.titleLabel.font = [UserContext getTheFontWithName:@"PingFangSC-Regular" size:17];
    lastHighLightIndex = index;
}


/** key是title，value是controller **/
-(void)setData:(NSArray *)array{
    self.dataArray = array;
    
    tabWidth = self.view.frame.size.width/array.count;
    [self.titleView addSubview:self.lineView];
    self.lineView.frame = CGRectMake(0, 34, tabWidth, 2);
    self.bgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*array.count, self.view.frame.size.height);
    /** 这个地方有待改进，到时候写一个类似的控件 **/
    for (int i = 0; i<array.count; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        UIButton  *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tabButton.tag = 100+i;
        [tabButton setTitleColor:RGBCOLOR(40, 40, 40) forState:UIControlStateNormal];
        [tabButton setTitleColor:RGBCOLOR(37, 37, 37) forState:UIControlStateSelected];
        [tabButton setTitle:dict.allKeys.firstObject forState:UIControlStateNormal];
        tabButton.selected = NO;
        tabButton.titleLabel.font = [UserContext getTheFontWithName:@"PingFangSC-Regular" size:13];
        [tabButton addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [tabButton setFrame:CGRectMake(tabWidth * i, 0, tabWidth, 34)];
        [self.titleView addSubview:tabButton];
        
        UIViewController *subVc = dict.allValues.firstObject;
        subVc.view.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addChildViewController:subVc];
        [self.bgScrollView addSubview:subVc.view];
    }
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
