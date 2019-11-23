//
//  JKNoneDataView.m
//  Doctor
//
//  Created by joy’s mac  on 2018/3/29.
//  Copyright © 2018年 cy. All rights reserved.
//

#import "JKNoneDataView.h"

@interface JKNoneDataView()

@property (nonatomic,strong)NSString  *showStr;

@end

@implementation JKNoneDataView

+(instancetype)initNoneDataViewWithFrame:(CGRect)frame type:(NSString *)showStr{
    // TODO: 此处处理与  直接调用frame的不同之处
//    CGFloat height1 =iPhoneX ? 88 : 64;
    CGFloat Height =frame.size.height;
    JKNoneDataView *view =[[JKNoneDataView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, Height)];
    view.backgroundColor =[UIColor whiteColor];
    view.showStr = showStr;
    return view;
}

#pragma mark - private method
-(void)cofnigueSubViews{
    
    UIView *noDataView =[UIView new];
    [self addSubview:noDataView];
    
    [noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.center.equalTo(self);
        make.height.mas_equalTo(128);
    }];
    
    UIImageView *noDataImg =[UIImageView new];
    noDataImg.image =[UIImage imageNamed:@"nodata"];
    [noDataView addSubview:noDataImg];
    
    [noDataImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(noDataView);
        make.width.mas_equalTo(197);
        make.height.mas_equalTo(197);
    }];
    
    UILabel *noDataLab =[UILabel new];
    noDataLab.font =[UIFont systemFontOfSize:13];
    noDataLab.textColor =RGBCOLOR(161, 161, 161);
    noDataLab.text =self.showStr;
    noDataLab.textAlignment =NSTextAlignmentCenter;
    [noDataView addSubview:noDataLab];
    
    [noDataLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noDataImg.mas_bottom).offset(10);
        make.centerX.equalTo(noDataImg);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark - setters
- (void)setShowStr:(NSString *)showStr {
    _showStr = showStr;
    [self cofnigueSubViews];
}


@end
