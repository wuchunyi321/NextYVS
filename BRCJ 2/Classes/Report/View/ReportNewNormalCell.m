//
//  ReportNewNormalCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/9/29.
//  Copyright © 2019 cy. All rights reserved.
//

#import "ReportNewNormalCell.h"
#import "ReportListModel.h"

@interface ReportNewNormalCell()

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *dateLabel;

@property (nonatomic,strong)UIImageView  *iconImage;

@property (nonatomic,strong)UILabel     *lookLabel;

@end

@implementation ReportNewNormalCell

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
    }
    return _iconImage;
}

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

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.textColor = RGBCOLOR(140, 140, 140);
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
    }
    return _dateLabel;
}

- (UILabel *)lookLabel{
    if (!_lookLabel) {
        _lookLabel = [UILabel new];
        _lookLabel.textColor = RGBCOLOR(140, 140, 140);
        _lookLabel.textAlignment = NSTextAlignmentLeft;
        _lookLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
    }
    return _lookLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-30);
        }];
        
        [self.contentView addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(20);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.height.mas_equalTo(12);
        }];
        
        [self.contentView addSubview:self.iconImage];
        [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
        
        [self.contentView addSubview:self.lookLabel];
        [self.lookLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
        
        UIImageView *lookImage = [[UIImageView alloc] init];
        [self.contentView addSubview:lookImage];
        [lookImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
        
        UIView *underLine = [UIView new];
        underLine.backgroundColor = RGBCOLOR(209, 209, 209);
        [self.contentView addSubview:underLine];
        [underLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}


- (void)loadTheCellWith:(ReportListModel *)item{
    
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
