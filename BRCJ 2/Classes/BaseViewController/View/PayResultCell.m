//
//  PayResultCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/11/27.
//  Copyright © 2019 cy. All rights reserved.
//

#import "PayResultCell.h"



@interface PayResultCell()

@property (nonatomic,strong)UIImageView *reslutImage;

@property (nonatomic,strong)UILabel     *reslutLabel;

@end


@implementation PayResultCell

- (UIImageView *)reslutImage{
    if (!_reslutImage) {
        _reslutImage = [[UIImageView alloc] init];
    }
    return _reslutImage;
}

- (UILabel *)reslutLabel{
    if (!_reslutLabel) {
        _reslutLabel = [UILabel new];
        _reslutLabel.textAlignment = NSTextAlignmentCenter;
        _reslutLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:16];
    }
    return _reslutLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.reslutImage];
        [self.contentView addSubview:self.reslutLabel];
        
        [self.reslutImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(18);
            make.width.height.mas_equalTo(43);
        }];
        
        [self.reslutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.reslutImage.mas_bottom).offset(10);
            make.height.mas_equalTo(16);
        }];
    }
    return self;
}

- (void)loadTheCellWithResult:(BOOL)result{
    if (result) { //成功
        self.reslutImage.image = [UIImage imageNamed:@"pay_success"];
        self.reslutLabel.textColor = RGBCOLOR(9, 186, 7);
        self.reslutLabel.text = @"支付成功";
    }else{
        self.reslutImage.image = [UIImage imageNamed:@"pay_failed"];
        self.reslutLabel.textColor = RGBCOLOR(255, 41, 0);
        self.reslutLabel.text = @"支付失败";
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
