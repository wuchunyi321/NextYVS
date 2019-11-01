//
//  MineFriendsViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/5.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineFriendsViewController.h"

#import "MineFriendListViewController.h"

NSInteger const mineSwitch =1314;
NSInteger const mineHeaderHeight =40.0f;

NSInteger const minestillInde =3;
CGFloat const minerightSideWidt =25;

@interface MineFriendsViewController ()<UIScrollViewDelegate>{
    
    UIView *_bottomView;
    UIScrollView *_titleScroll;
    UIScrollView *_scroll;
    
    CGFloat titleTotalOffset;
    CGFloat titleOffset;
    
    NSString *_currentTitle;
    
    CGFloat minetitleBtnWidth;
}

@property(nonatomic,assign)NSInteger switchIndex;
@property(nonatomic,strong)NSMutableArray *newsTitleArr;

@property(nonatomic,strong)NSMutableArray *btnsArr;

@property(nonatomic,strong)NSMutableArray *allVCArr;

@end

@implementation MineFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self hideBackButton];
    minetitleBtnWidth = SCREEN_WIDTH/3.0;
    [self.newsTitleArr addObjectsFromArray:@[@"云友",@"视友",@"届友"]];
    self.switchIndex = mineSwitch;
    [self initHeadSwitch];
    [self initScrollView];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _scroll) {
        CGFloat offset =scrollView.contentOffset.x;
        [self handleScrollEffect:offset/SCREEN_WIDTH];
    }
}

#pragma mark - click events
-(void)newsBtnSwitchClick:(UIButton *)btn{
    
    NSInteger tag =btn.tag;
    if (tag == self.switchIndex)
        return;
    
    NSInteger bottomViewIndex =btn.tag - mineSwitch;
    [_scroll setContentOffset:CGPointMake(bottomViewIndex * SCREEN_WIDTH, 0) animated:YES];
    
    [self handleScrollEffect:bottomViewIndex];
}

#pragma mark - handleScrollEffect
-(void)handleScrollEffect:(NSInteger)scrollIndex{
    
    // 轻滑后留在原位  效果不变
    if (self.switchIndex == mineSwitch + scrollIndex)
        return;
    
    [UIView animateWithDuration:0.25 animations:^{
        self->_bottomView.center =CGPointMake(minetitleBtnWidth/2.0 + minetitleBtnWidth * scrollIndex, mineHeaderHeight - 4);
    }];
    
    UIButton *btn =[self.view viewWithTag:mineSwitch + scrollIndex];
    [btn setSelected:YES];
    
    UIButton *lastBtn =[self.view viewWithTag:self.switchIndex];
    [lastBtn setSelected:NO];
    
    self.switchIndex =mineSwitch + scrollIndex;
    
    if (_titleScroll.contentSize.width > SCREEN_WIDTH) {
        
        if (scrollIndex <= minestillInde)
            [_titleScroll setContentOffset:CGPointMake(0, 0) animated:YES];
        
        else if (scrollIndex > minestillInde && scrollIndex < self.newsTitleArr.count - minestillInde)
            [_titleScroll setContentOffset:CGPointMake(titleOffset * (scrollIndex - minestillInde), 0) animated:YES];
        else
            [_titleScroll setContentOffset:CGPointMake(titleTotalOffset, 0) animated:YES];
        
    }
    
    //  TODO:进一步总结  找一个更加优化的方法
    if ([self.allVCArr[scrollIndex] isKindOfClass:[NSString class]]) {
        
        MineFriendListViewController *medicineVC =[MineFriendListViewController new];
        medicineVC.detailType =self.newsTitleArr[scrollIndex];
        [medicineVC.view setFrame:CGRectMake(SCREEN_WIDTH * scrollIndex, 0, SCREEN_WIDTH, _scroll.frame.size.height)];
        [self addChildViewController:medicineVC];
        [_scroll addSubview:medicineVC.view];

        [self.allVCArr replaceObjectAtIndex:scrollIndex withObject:medicineVC];
    }
    
    _currentTitle =self.newsTitleArr[scrollIndex];
}

#pragma mark - resetAllNewsAfterSorted
-(void)resetAllNewsAfterSorted{
    
    NSMutableArray *specialArr =[NSMutableArray arrayWithArray:self.allVCArr];
    
    for (int i =0; i < self.newsTitleArr.count; i ++) {
        
        // 标题重置
        UIButton *btn =self.btnsArr[i];
        [btn setTitle:self.newsTitleArr[i] forState:UIControlStateNormal];
        
        // MedicineNewsVC 或 allVCArr的字符串元素   位置重置
        if (i > 0) {//  第一个  “热点”  的位置始终不会变化
            
            if ([specialArr[i] isKindOfClass:[MineFriendListViewController class]]) {

                MineFriendListViewController *movedVC =specialArr[i];
                /** 这个地方需要改一下 **/
                NSInteger shouldBeIndex =[self.newsTitleArr indexOfObject:movedVC.detailType];

                // 不相等 说明vc位置已经发生了变化
                if (shouldBeIndex != i){

                    [movedVC.view setFrame:CGRectMake(SCREEN_WIDTH * shouldBeIndex, 0, SCREEN_WIDTH, _scroll.frame.size.height)];
                    [self.allVCArr replaceObjectAtIndex:shouldBeIndex withObject:movedVC];
                }

            }else{

                NSString *title =specialArr[i];
                NSInteger shouldBeIndex =[self.newsTitleArr indexOfObject:title];

                // 不相等 说明此处位置已经发生了变化
                if (shouldBeIndex != i)
                    [self.allVCArr replaceObjectAtIndex:shouldBeIndex withObject:title];
            }
        }
    }
    
    // 原选中的新闻VC 重置
    if (_currentTitle.length > 0) {
        
        NSInteger currentIndex =[self.newsTitleArr indexOfObject:_currentTitle];
        [self handleScrollEffect:currentIndex];
        [_scroll setContentOffset:CGPointMake(currentIndex * SCREEN_WIDTH, 0) animated:YES];
    }
    
}

#pragma mark - init views
-(void)initScrollView{
    
    CGFloat top =iPhoneX ? (88  + mineHeaderHeight ): (64  + mineHeaderHeight);
    CGFloat height =SCREEN_HEIGHT - top;
    
    _scroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, mineHeaderHeight+TopHeight, SCREEN_WIDTH, height)];
    _scroll.delegate =self;
    _scroll.showsHorizontalScrollIndicator =NO;
    _scroll.pagingEnabled =YES;
    [self.view addSubview:_scroll];
    
    MineFriendListViewController *medicineVC =[MineFriendListViewController new];
    medicineVC.detailType = @"云友";
    [medicineVC.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    [self addChildViewController:medicineVC];
    [_scroll addSubview:medicineVC.view];

    [self.allVCArr replaceObjectAtIndex:0 withObject:medicineVC];
    
    _scroll.contentSize =CGSizeMake(self.newsTitleArr.count * SCREEN_WIDTH, height);
}


-(void)initHeadSwitch{
    
    _titleScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH,mineHeaderHeight)];
    _titleScroll.delegate =self;
    _titleScroll.showsHorizontalScrollIndicator =NO;
    _titleScroll.backgroundColor =RGBCOLOR(245, 245, 245);
    [self.view addSubview:_titleScroll];
    
    _titleScroll.contentSize =CGSizeMake(self.newsTitleArr.count * minetitleBtnWidth + minerightSideWidt, 40);
    
    for (int i =0; i < self.newsTitleArr.count; i ++) {
        
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(i * minetitleBtnWidth, 0, minetitleBtnWidth, mineHeaderHeight)];
        [btn setTitle:self.newsTitleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:RGBCOLOR(37, 37, 37) forState:UIControlStateSelected];
        btn.tag =mineSwitch + i;
        btn.titleLabel.font =[UIFont systemFontOfSize:13];
        [btn addTarget:self action:@selector(newsBtnSwitchClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titleScroll addSubview:btn];
        
        [self.btnsArr addObject:btn];
        
        if (i == 0)
            [btn setSelected:YES];
        
    }
    
    _bottomView =[UIView new];
    _bottomView.center =CGPointMake(minetitleBtnWidth/2.0, mineHeaderHeight - 4);
    _bottomView.bounds =CGRectMake(0, 0, 20, 2);
    _bottomView.backgroundColor =RGBCOLOR(250, 50, 57);
    [_titleScroll addSubview:_bottomView];
    
    titleTotalOffset =_titleScroll.contentSize.width - SCREEN_WIDTH;
    titleOffset =titleTotalOffset/(self.newsTitleArr.count - 1 - minestillInde * 2);
}

#pragma mark - getters

-(NSMutableArray *)newsTitleArr{
    
    if (!_newsTitleArr) {
        _newsTitleArr =[NSMutableArray new];
    }
    return _newsTitleArr;
}

-(NSMutableArray *)allVCArr{
    
    if (!_allVCArr) {
        _allVCArr =[NSMutableArray new];
        
        for (NSString *title in self.newsTitleArr) {
            
            [_allVCArr addObject:title];
        }
    }
    return _allVCArr;
}

-(NSMutableArray *)btnsArr{
    
    if (!_btnsArr) {
        _btnsArr =[NSMutableArray new];
    }
    return _btnsArr;
}
@end
