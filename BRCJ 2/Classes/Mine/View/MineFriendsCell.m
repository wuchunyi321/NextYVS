//
//  MineFriendsCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/21.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineFriendsCell.h"
#import "FriendsModel.h"

@interface MineFriendsCell()

@property (nonatomic,strong)UIImageView *avatarImage;

@property (nonatomic,strong)UILabel     *titleLabel;

@property (nonatomic,strong)UILabel    *detailLabel;

@property (nonatomic,strong)UILabel    *timeLabel;

@end

@implementation MineFriendsCell

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = RGBCOLOR(46, 46, 46);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:15];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.textColor = RGBCOLOR(133, 133, 133);
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
    }
    return _detailLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = RGBCOLOR(133, 133, 133);
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
    }
    return _timeLabel;
}

- (UIImageView *)avatarImage{
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] init];
        _avatarImage.image = [UIImage imageNamed:@"report_avatar_default"];
    }
    return _avatarImage;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.avatarImage];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.timeLabel];
        
        [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
            make.height.width.mas_equalTo(50);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarImage.mas_right).offset(15);
            make.top.equalTo(self.contentView).offset(20);
            make.height.mas_equalTo(18);
            make.width.mas_equalTo(150);
        }];
        
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarImage.mas_right).offset(15);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(150);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16);
            make.top.equalTo(self.contentView.mas_top).offset(18);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(14);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0xf3f3f4);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)loadTheCellWith:(FriendsModel *)item{
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:item.headPortrait] placeholderImage:[UIImage imageNamed:@"report_avatar_default"]];
//    self.timeLabel.text = [BRTool timeStringFromDataToNow:item.addTime]; //如果按天算的话需要更改,bug存在
    self.titleLabel.text = item.nickname;
//    self.detailLabel.text = item.inviteCode;
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
