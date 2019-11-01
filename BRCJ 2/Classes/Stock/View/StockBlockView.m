//
//  StockBlockView.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import "StockBlockView.h"
#import "UIImage+GradientColor.h"

@interface StockBlockView ()

@property (nonatomic,strong)UILabel     *headlabel;
@property (nonatomic,strong)UILabel     *titlelabel;
@property (nonatomic,strong)UILabel     *contentLabel;
@property (nonatomic,strong)UIImageView  *bgImage;

@end


@implementation StockBlockView

- (UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc] init];
    }
    return _bgImage;
}

- (UILabel *)headlabel{
    if (!_headlabel){
        _headlabel = [UILabel new];
        _headlabel.textAlignment = NSTextAlignmentCenter;
        _headlabel.textColor = RGBCOLOR(33, 33, 33);
        _headlabel.backgroundColor = [UIColor clearColor];
        _headlabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
    }
    return _headlabel;
}

- (UILabel *)titlelabel{
    if (!_titlelabel){
        _titlelabel = [UILabel new];
        _titlelabel.textAlignment = NSTextAlignmentCenter;
        _titlelabel.backgroundColor = [UIColor clearColor];
        _titlelabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:18];
    }
    return _titlelabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel){
        _contentLabel = [UILabel new];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:10];
    }
    return _contentLabel;
}

- (id)init{
    if (self = [super init]) {
        [self addSubview:self.bgImage];
        [self addSubview:self.headlabel];
        [self addSubview:self.titlelabel];
        [self addSubview:self.contentLabel];
    }
    return self;
}

- (void)setWidget{
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    [self.headlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(6);
        make.height.mas_equalTo(12);
    }];
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerY.equalTo(self);
        make.height.mas_equalTo(18);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-12);
        make.height.mas_equalTo(12);
    }];
}

/** 上证指数 **/
- (void)loadTheShangwith:(NSString *)str{
    NSArray *array = [str componentsSeparatedByString:@","];
    if (array.count < 4) {
        return;
    }
    self.headlabel.text = [array objectAtIndex:0];
    NSString *number = [array objectAtIndex:1];
    self.titlelabel.text = [NSString stringWithFormat:@"%6.2f",number.floatValue];
    NSString *upNumber = [array objectAtIndex:2];
    NSString *upPercent = [array objectAtIndex:3];
    
    if (upNumber.floatValue > 0) {
        self.bgImage.image = [UIImage imageNamed:@"stock_rise"];
        self.contentLabel.text = [NSString stringWithFormat:@"+%5.2f +%@%%",upNumber.floatValue,upPercent];
        self.titlelabel.textColor = RGBCOLOR(255, 52, 58);
        self.contentLabel.textColor = RGBCOLOR(255, 52, 58);
        
    }else{
        self.bgImage.image = [UIImage imageNamed:@"stock_fall"];
        self.contentLabel.text = [NSString stringWithFormat:@"%5.2f %@%%",upNumber.floatValue,upPercent];
        self.titlelabel.textColor = RGBCOLOR(34, 147, 43);
        self.contentLabel.textColor = RGBCOLOR(34, 147, 43);
        
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_delegate && [_delegate respondsToSelector:@selector(viewClicked:)]){
        [_delegate performSelector:@selector(viewClicked:) withObject:self];
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
