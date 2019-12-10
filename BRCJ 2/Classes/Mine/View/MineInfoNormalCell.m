//
//  MineInfoNormalCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/5.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineInfoNormalCell.h"

@interface MineInfoNormalCell()

@property (nonatomic,strong)UILabel     *titlelabel;

@property (nonatomic,strong)UIImageView  *arrowImage;
@property (nonatomic,strong)UIImageView  *avatarImage;

@property (nonatomic,strong)UILabel      *valueLabel;

@property (nonatomic,strong)UIView       *underLine;

@end


@implementation MineInfoNormalCell

- (UILabel *)titlelabel{
    if (!_titlelabel) {
        _titlelabel = [UILabel new];
        _titlelabel.textColor = RGBCOLOR(37, 37, 37);
        _titlelabel.textAlignment = NSTextAlignmentLeft;
        _titlelabel.font = [UIFont systemFontOfSize:14];
    }
    return _titlelabel;
}

- (UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [UILabel new];
        _valueLabel.textColor = RGBCOLOR(37, 37, 37);
        _valueLabel.textAlignment = NSTextAlignmentRight;
        _valueLabel.font = [UIFont systemFontOfSize:12];
    }
    return _valueLabel;
}

- (UIImageView *)avatarImage{
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] init];
        _avatarImage.image = [UIImage imageNamed:@"BRSource.bundle/report_avatar_default"]; //7*12
    }
    return _avatarImage;
}

- (UIImageView *)arrowImage{
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] init];
        _arrowImage.image = [UIImage imageNamed:@"BRSource.bundle/next"]; //7*12
    }
    return _arrowImage;
}

- (UIView *)underLine{
    if (!_underLine) {
        _underLine = [UIView new];
        _underLine.backgroundColor = RGBCOLOR(232, 232, 232);
    }
    return _underLine;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titlelabel];
        [self.contentView addSubview:self.arrowImage];
        [self.contentView addSubview:self.underLine];
        [self.contentView addSubview:self.avatarImage];
        [self.contentView addSubview:self.valueLabel];
       
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.centerY.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-0.5);
            make.width.mas_equalTo(100);
        }];
        
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-16);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(7);
            make.height.mas_equalTo(12);
        }];
        
        [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
        
        [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(43);
            make.right.equalTo(self.contentView).offset(-16);
            make.centerY.equalTo(self.contentView);
        }];
        
        [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImage.mas_left).offset(-5);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(150);
        }];
    }
    return self;
}

- (void)loadTheCellWithType:(MineInfoNormalCellType )type value:(NSString *)value{
    self.valueLabel.text = value;
    self.valueLabel.hidden = NO;
    switch (type) {
        case MineInfoNormalCellTypeAvatar:{
            self.avatarImage.hidden = NO;
            self.arrowImage.hidden = YES;
            self.valueLabel.hidden = YES;
            self.titlelabel.text = @"头像";
            if (value && value.length > 0) {
                [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:value] placeholderImage:[UIImage imageNamed:@"BRSource.bundle/report_avatar_default"]];
            }
        }
            break;
        case MineInfoNormalCellTypeName:{
            self.avatarImage.hidden = YES;
            self.arrowImage.hidden = NO;
            self.titlelabel.text = @"姓名";
        }
            break;
        case MineInfoNormalCellTypeNickName:{
            self.avatarImage.hidden = YES;
            self.arrowImage.hidden = NO;
            self.titlelabel.text = @"昵称";
        }
            break;
        case MineInfoNormalCellTypeSex:{
            self.avatarImage.hidden = YES;
            self.arrowImage.hidden = NO;
            self.titlelabel.text = @"性别";
        }
            break;
        case MineInfoNormalCellTypePhone:{
            self.avatarImage.hidden = YES;
            self.arrowImage.hidden = NO;
            self.titlelabel.text = @"手机号";
        }
            break;
        case MineInfoNormalCellTypeClear:{
            self.avatarImage.hidden = YES;
            self.arrowImage.hidden = NO;
            self.titlelabel.text = @"清除缓存";
        }
            break;
        case MineInfoNormalCellTypeVersionUpdate:{
            self.avatarImage.hidden = YES;
            self.arrowImage.hidden = NO;
            self.titlelabel.text = @"版本更新";
        }
            break;
        case MineInfoNormalCellTypeMoney:{
            self.avatarImage.hidden = YES;
            self.arrowImage.hidden = NO;
            self.titlelabel.text = @"提现";
        }
            break;
        default:
            break;
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
