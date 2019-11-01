//
//  ReportHeadView.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import "ReportHeadView.h"

#import "ReportPersonModel.h"

@interface ReportHeadView()<CardItemViewDelegate>

@property (nonatomic,strong)UIScrollView  *bgScrollView;

@property (nonatomic,strong)UILabel       *titleLabel;

@end

@implementation ReportHeadView

- (UIScrollView *)bgScrollView{
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] init];
        _bgScrollView.backgroundColor = [UIColor clearColor];
        _bgScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _bgScrollView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = RGBCOLOR(34, 34, 34);
        _titleLabel.text = @"为你推荐";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:16];
    }
    return _titleLabel;
}

///**  test**/
//- (void)loadTestViewWithDelegate:(id<CardItemViewDelegate>)delegate{
//    [self addSubview:self.titleLabel];
//    self.titleLabel.frame = CGRectMake(20, 20, 200, 16);
//    
//    [self addSubview:self.bgScrollView];
//    self.bgScrollView.frame = CGRectMake(0, 20+16+15, SCREEN_WIDTH, 127);
//    self.bgScrollView.contentSize = CGSizeMake(6*(95+20), 127);
//    
//    for (int i = 0; i<6; i++) {
//        CardItemView *item = [[CardItemView alloc] init];
//        item.delegate = delegate;
//        item.frame = CGRectMake(20+(95+20)*i, 0, 95, 127);
//        item.layer.borderColor = [UIColor grayColor].CGColor;
//        item.layer.borderWidth = 0.5;
//        [self.bgScrollView addSubview:item];
//    }
//}

- (void)loadTheViewWith:(NSArray *)items withDelegate:(id<CardItemViewDelegate>)delegate{
    [self addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(20+4+10, 20, 200, 16);
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = RGBCOLOR(255, 52, 58);
    [self addSubview:lineView];
    lineView.frame = CGRectMake(20, 20, 4, 16);
    
    [self addSubview:self.bgScrollView];
    self.bgScrollView.frame = CGRectMake(0, 20+16+15, SCREEN_WIDTH, 127);
    self.bgScrollView.contentSize = CGSizeMake((items.count)*(95+20), 127);
    
    for (int i = 0; i<items.count; i++) {
        CardItemView *item = [[CardItemView alloc] initWithFrame:CGRectMake(20+(95+20)*i, 0, 95, 127)];
        item.delegate = delegate;
        item.layer.borderColor = [UIColor grayColor].CGColor;
        item.layer.borderWidth = 0.5;
        item.tag = i+1;
        [self.bgScrollView addSubview:item];
        [item loadTheViewWith:[items objectAtIndex:i]];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
