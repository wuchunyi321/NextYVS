//
//  MineCardImageView.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/6.
//  Copyright © 2019 cy. All rights reserved.
//


/**
 width 343
 height 64
 label 离左边距离 75
 arrow 离右边距离 23
 比例  mulNumber
 */

#import "MineCardImageView.h"

#import "BankCardModel.h"

@interface MineCardImageView()

@property (nonatomic,strong)UILabel *bankName;

@property (nonatomic,strong)UILabel *otherInfoLabel;

@property (nonatomic,strong)UILabel *isChooseLabel;

@property (nonatomic,strong)UIImageView *arrowImage;

@end


@implementation MineCardImageView

- (UILabel *)bankName{
    if (!_bankName) {
        _bankName = [UILabel new];
        _bankName.textColor = [UIColor whiteColor];
        _bankName.textAlignment = NSTextAlignmentLeft;
        _bankName.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:14];
        _bankName.backgroundColor = [UIColor clearColor];
    }
    return _bankName;
}

- (UILabel *)otherInfoLabel{
    if (!_otherInfoLabel) {
        _otherInfoLabel = [UILabel new];
        _otherInfoLabel.textColor = [UIColor whiteColor];
        _otherInfoLabel.textAlignment = NSTextAlignmentLeft;
        _otherInfoLabel.backgroundColor = [UIColor clearColor];
        _otherInfoLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:13];
    }
    return _otherInfoLabel;
}

- (UILabel *)isChooseLabel{
    if (!_isChooseLabel) {
        _isChooseLabel = [UILabel new];
        _isChooseLabel.backgroundColor = RGBCOLOR(3, 35, 170);
        _isChooseLabel.textAlignment = NSTextAlignmentCenter;
        _isChooseLabel.textColor = [UIColor whiteColor];
        _isChooseLabel.text = @"默认";
        _isChooseLabel.font =[UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
        _isChooseLabel.layer.cornerRadius = 7;
        _isChooseLabel.layer.masksToBounds = YES;
    }
    return _isChooseLabel;
}

- (UIImageView *)arrowImage{
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]]; //7*12
         _arrowImage.backgroundColor = [UIColor clearColor];
    }
    return _arrowImage;
}

- (instancetype)initWithImage:(UIImage *)image{
    if (self = [super initWithImage:image]) {
        [self addSubview:self.bankName];
        [self addSubview:self.otherInfoLabel];
        [self addSubview:self.isChooseLabel];
        [self addSubview:self.arrowImage];
        
        self.bankName.frame = CGRectMake(75*mulNumber, 13*mulNumber, 120*mulNumber, 14);
        self.otherInfoLabel.frame = CGRectMake(75*mulNumber, 13*mulNumber+10+14, 150*mulNumber, 14);
        self.isChooseLabel.frame = CGRectMake(75*mulNumber+120*mulNumber+10, 13*mulNumber, 44, 14);
        self.arrowImage.frame = CGRectMake(CARDWIDTH-23-7, (CARDHEIGHT-12)/2, 7, 12);
    }
    return self;
}

/** 测试数据
 */
-(void)loadTheCardImageWith:(NSString *)title
                       info:(NSString *)info
                   isChoose:(BOOL)ischoose
                   hasArrow:(BOOL) hasArrow{
    self.bankName.text = title;
    self.otherInfoLabel.text = info;
    self.isChooseLabel.hidden = !ischoose;
    self.arrowImage.hidden = !hasArrow;
}

- (void)loadTheCellWith:(BankCardModel *)model{
    if (model != nil) {
        self.bankName.text = model.bankName;
        self.otherInfoLabel.text = [NSString stringWithFormat:@"尾号为%@ 储蓄卡",[model.bankCardNumber substringFromIndex:model.bankCardNumber.length-4]];
        self.isChooseLabel.hidden = (model.isDefault.intValue != 1);
        self.arrowImage.hidden = NO;
    }else{
        self.isChooseLabel.hidden = YES;
    }
}

- (void)loadTheListCellWith:(BankCardModel *)model{
    self.bankName.text = model.bankName;
    self.otherInfoLabel.text = [NSString stringWithFormat:@"尾号为%@ 储蓄卡",[model.bankCardNumber substringFromIndex:model.bankCardNumber.length-4]];
    self.isChooseLabel.hidden = (model.isDefault.intValue != 1);
    self.arrowImage.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_delegate && [_delegate respondsToSelector:@selector(viewClicked:)]){
        [_delegate performSelector:@selector(viewClicked:) withObject:self];
    }
}

@end
