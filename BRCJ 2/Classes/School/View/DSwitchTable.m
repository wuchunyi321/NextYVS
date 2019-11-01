//
//  DSwitchTable.m
//  Doctor
//
//  Created by wuchunyi on 2017/12/25.
//  Copyright © 2017年 cy. All rights reserved.
//

#import "DSwitchTable.h"

@interface DSwitchTable()<UIScrollViewDelegate>{
    UIView        *tabBgView;
    UIScrollView  *bgScrollView;
    UIView        *bottomView;
    NSInteger lastHighLightIndex;
    BOOL   isLayout;
    CGFloat tabWidth;
}

/** 存放已经加载的Controller **/
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation DSwitchTable


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        lastHighLightIndex = -1;

        tabBgView = [[UIView alloc] init];
        tabBgView.backgroundColor = [UIColor greenColor];
        
        bgScrollView = [[UIScrollView alloc] init];
        bgScrollView.delegate = self;
        bgScrollView.backgroundColor = [UIColor yellowColor];
        bgScrollView.pagingEnabled = YES;
        bgScrollView.showsVerticalScrollIndicator = NO;
        bgScrollView.showsHorizontalScrollIndicator = NO;
        bgScrollView.bounces = NO;
    }
    return self;
}

//调用drawRect方法
- (void)setNeedsDisplay{
    
}
//和layoutSubviews区别是啥呢？（刷新布局调用layoutSubviews，重新绘图调用drawRect）
- (void)drawRect:(CGRect)rect{
    
}

//计算出最优的size，并且改变自己的size
- (void)sizeToFit{
    
}
//计算出最优的size，并且返回，但是不改变自己的size
- (CGSize)sizeThatFits:(CGSize)size{
    return CGSizeZero;
}

//如果有变化调用layoutSubviews（什么用啊，不这样搞也会调用啊）
- (void)layoutIfNeeded{
    
}
//立即调用layoutSubviews
- (void)setNeedsLayout{
    
}

//更新布局就会调用（不会直接调用，级实例对象不能直接调用）
- (void)layoutSubviews{
    if (isLayout){
        return;
    }
    [super layoutSubviews];
    NSInteger tabNumber = 0;
    NSArray *titles = nil;
    if (_delegate && [_delegate respondsToSelector:@selector(titlesOfSwitchTable:)]){
        titles = [_delegate titlesOfSwitchTable:self];
    }
    tabNumber = titles.count;
    tabWidth = self.frame.size.width / tabNumber;
    
    for (int i = 0; i<tabNumber; i++){
        UIButton  *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tabButton.tag = 100+i;
        [tabButton setTitleColor:RGBCOLOR(40, 40, 40) forState:UIControlStateNormal];
        [tabButton setTitleColor:RGBCOLOR(37, 37, 37) forState:UIControlStateSelected];
        [tabButton setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        tabButton.selected = NO;
        tabButton.titleLabel.font = [UserContext getTheFontWithName:@"PingFangSC-Regular" size:13];
        [tabButton addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [tabButton setFrame:CGRectMake(tabWidth * i, 0, tabWidth, 50)];
        [tabBgView addSubview:tabButton];
    }
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 48, tabWidth, 2)];
    bottomView.backgroundColor = RGBCOLOR(255, 50, 57);
    [tabBgView addSubview:bottomView];
    
    NSIndexPath  *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self loadContentView:indexPath];
    
    [bgScrollView setContentSize:CGSizeMake(tabNumber*SCREEN_WIDTH, self.frame.size.height-50)];
    
    tabBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    [self addSubview:tabBgView];
    bgScrollView.frame = CGRectMake(0, 50, SCREEN_WIDTH, self.frame.size.height-50);
    [self addSubview:bgScrollView];
    [self hightLightButton:0];
    
    UIView  *underLine = [[UIView alloc] init];
    underLine.backgroundColor = UIColorFromRGB(0xeeeeee);
    underLine.frame = CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5);
    [tabBgView addSubview:underLine];
    
    isLayout = YES;
}

- (void)loadContentView:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(contentOfSwitchTable:atIndexPath:)]){
        UIViewController *contentController = [_delegate contentOfSwitchTable:self atIndexPath:indexPath];
        UIView *contentView = contentController.view;
        [contentView setFrame:CGRectMake(SCREEN_WIDTH*indexPath.row, 0, self.frame.size.width, self.frame.size.height-50)];
        contentView.tag = 10000 + indexPath.row;
        [bgScrollView addSubview:contentView];
    }
}

- (void)showContentView:(NSIndexPath *)indexPath{
    UIView *contentView = [bgScrollView viewWithTag:10000 + indexPath.row];
    if (contentView == nil){
        [self loadContentView:indexPath];
    }else{ //把已经加载的显示出来
        if (_delegate && [_delegate respondsToSelector:@selector(contentOfSwitchTable:atIndexPath:)]){
            UIViewController *contentController = [_delegate contentOfSwitchTable:self atIndexPath:indexPath];
            [contentController viewDidAppear:YES];
        }
    }
}

-(void)btnClicked:(UIButton *)sender
{
    UIButton *btnTab = (UIButton *)sender;
    
    if (_selectedIndex != -1)
    {
        NSIndexPath *indexDePath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
        if (_delegate && [_delegate respondsToSelector:@selector(switchTable:didDeSelectedTab:)])
        {
            [_delegate switchTable:self didDeSelectedTab:indexDePath];
        }
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(btnTab.tag-100) inSection:0];
    [self showContentView:indexPath];
    
    if (_delegate && [_delegate respondsToSelector:@selector(switchTable:didSelectedTab:)])
    {
        [_delegate switchTable:self didSelectedTab:indexPath];
    }
    self.selectedIndex = indexPath.row;
    
    [UIView beginAnimations:@"buttomAni" context:nil];
    CGFloat xOffset = tabWidth * (btnTab.tag - 100);
    [bottomView setFrame:CGRectMake(xOffset, 48, tabWidth, 2)];
    bgScrollView.contentOffset = CGPointMake(SCREEN_WIDTH * (btnTab.tag -100), 0);
    [UIView commitAnimations];
    [self hightLightButton:self.selectedIndex];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (bgScrollView.contentOffset.x < 0
        || (bgScrollView.contentOffset.x + bgScrollView.frame.size.width) > bgScrollView.contentSize.width) {
        return;
    }
    CGFloat xOffset = SCREEN_WIDTH * (bgScrollView.contentOffset.x / bgScrollView.contentSize.width);
    [UIView beginAnimations:@"buttomAni" context:nil];
    [bottomView setFrame:CGRectMake(xOffset, 48, tabWidth, 2)];
    [UIView commitAnimations];
    NSInteger tabIndex = xOffset / tabWidth;
    //不再进行跳转
    if (tabIndex == _selectedIndex)
    {
        return;
    }
    
    if (_selectedIndex != -1)
    {
        NSIndexPath *indexDePath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
        if (_delegate && [_delegate respondsToSelector:@selector(switchTable:didDeSelectedTab:)])
        {
            [_delegate switchTable:self didDeSelectedTab:indexDePath];
        }
    }
    
    [self hightLightButton:tabIndex];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tabIndex inSection:0];
    [self showContentView:indexPath];
    
    if (_delegate && [_delegate respondsToSelector:@selector(switchTable:didSelectedTab:)]){
        [_delegate switchTable:self didSelectedTab:indexPath];
    }
    self.selectedIndex = tabIndex;
}

-(void)hightLightButton:(NSInteger)index{
    if (index == lastHighLightIndex){
        return;
    }
    UIButton *lastBtn = (UIButton *)[tabBgView viewWithTag:100+lastHighLightIndex];
    UIButton *nowBtn = (UIButton *)[tabBgView viewWithTag:100+index];
    lastBtn.selected = NO;
    lastBtn.titleLabel.font = [UserContext getTheFontWithName:@"PingFangSC-Regular" size:13];
    nowBtn.selected = YES;
    nowBtn.titleLabel.font = [UserContext getTheFontWithName:@"PingFangSC-Regular" size:17];
    lastHighLightIndex = index;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
