//
//  MineHomeHeaderCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/30.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineHomeHeaderCell.h"

@interface MineHomeHeaderCell()

@property (nonatomic,strong)UIImageView *avatar;

@property (nonatomic,strong)UILabel     *titleLabel;

@property (nonatomic,strong)UIImageView *levelImage;

@end


@implementation MineHomeHeaderCell

- (UIImageView *)levelImage{
    if (!_levelImage) {
        _levelImage = [[UIImageView alloc] init];
    }
    return _levelImage;
}

- (UIImageView *)avatar{
    if (!_avatar) {
        _avatar = [[UIImageView alloc] init];
    }
    return _avatar;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = RGBCOLOR(37, 37, 37);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.avatar];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.levelImage];
        [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(65);
            make.left.equalTo(self.contentView).offset(16);
            make.centerY.equalTo(self.contentView);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatar.mas_right).offset(10);
            make.top.equalTo(self.contentView).offset(20);
            make.width.mas_equalTo(120);
        }];
        
        [self.levelImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right);
            make.centerY.equalTo(self.titleLabel);
            make.width.mas_equalTo(27);
            make.height.mas_equalTo(14);
        }];
    }
    return self;
}

- (void)loadTheCellWithTitle:(NSString *)title andAvatar:(NSString *)avatar{
    MyMember *menber = [MyMember readFromFile];
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"BRSource.bundle/report_avatar_default"]];
    self.titleLabel.text = title;
    self.levelImage.hidden = NO;
    if (menber.vipLevel.intValue > 0) {
        CGSize labelSize = [self.titleLabel sizeThatFits:CGSizeZero];
        self.levelImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"BRSource.bundle/ic_userlevel_%@",menber.vipLevel]];
        [self.levelImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_left).offset(labelSize.width+10);
        }];
    }else{
        self.levelImage.hidden = YES;
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
