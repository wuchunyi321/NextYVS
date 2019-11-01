//
//  MineMessageCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/9/25.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineMessageCell.h"
#import "MineMessageModel.h"


@interface MineMessageCell()

@property (nonatomic,strong)UILabel     *titleLabel;
@property (nonatomic,strong)UILabel     *timeLabel;

@end

@implementation MineMessageCell

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = RGBCOLOR(34, 34, 34);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.bottom.equalTo(self.contentView).offset(-20);
        }];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-15);
            make.height.mas_equalTo(20);
        }];
        UIView *line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0xeeeeee);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)loadTheCellWith:(MineMessageModel *)item{
    NSDictionary *dict = [BRTool dictionaryWithJsonString:item.message];
    self.titleLabel.text = dict?dict[@"msg"]:@"未知错误"; //解析一下
    self.timeLabel.text = [item.updateTime substringToIndex:10];
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
