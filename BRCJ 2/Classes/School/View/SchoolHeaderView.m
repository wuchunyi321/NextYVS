//
//  SchoolHeaderView.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/19.
//  Copyright © 2019 cy. All rights reserved.
//

#import "SchoolHeaderView.h"

@interface SchoolHeaderView()

@property (nonatomic,strong)UILabel  *titleLabel;

@property (nonatomic,strong)UILabel  *detailLabel;

@end

@implementation SchoolHeaderView

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = RGBCOLOR(34, 34, 34);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.textColor = RGBCOLOR(84, 84, 84);
        _detailLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
        _detailLabel.numberOfLines = 2;
    }
    return _detailLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
            make.top.equalTo(self).offset(5);
            make.height.mas_equalTo(40);
        }];
        
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(35);
        }];
        
        UIView *undeline = [UIView new];
        undeline.backgroundColor = RGBCOLOR(209, 209, 209);
        [self addSubview:undeline];
        [undeline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)loadTheHeaderViewWithTitle:(NSString *)title detail:(NSString *)detail{
    self.titleLabel.text = title;
    self.detailLabel.text = detail;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
