//
//  LivingNormalCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/7.
//  Copyright © 2019 cy. All rights reserved.
//

#import "LivingNormalCell.h"

#import "LivingModel.h"

#define living_image_width        330*mulNumber
#define living_image_height       113*mulNumber

@interface LivingNormalCell()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *contentImage;
@property (nonatomic,strong)UILabel *detailLabel;

@end

@implementation LivingNormalCell

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"散户俱乐部";
        _titleLabel.textColor = RGBCOLOR(255, 52, 58);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Bold" size:14];
    }
    return _titleLabel;
}

- (UIImageView *)contentImage{
    if (!_contentImage) {
        _contentImage = [[UIImageView alloc] init];
    }
    return _contentImage;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.text = @"散户俱乐部详细介绍，介绍啥我也不知道，反正就是一个介绍，最多显示两行，再多就是空格";
        _detailLabel.textColor = RGBCOLOR(34, 34, 34);
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.numberOfLines = 2;
        _detailLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
    }
    return _detailLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(0xf3f3f4);
        
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = 5;
        bgView.layer.masksToBounds = YES;
        [self.contentView addSubview:bgView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.top.equalTo(self.contentView).offset(6);
            make.bottom.equalTo(self.contentView).offset(-6);
        }];
        
        [bgView addSubview:self.contentImage];
        [self.contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(living_image_width);
            make.height.mas_equalTo(living_image_height);
            make.centerX.equalTo(bgView);
            make.top.equalTo(bgView).offset(35);
        }];
        
        [bgView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentImage);
            make.bottom.equalTo(self.contentImage.mas_top);
            make.top.equalTo(bgView);
        }];
        
        [bgView addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentImage);
            make.bottom.equalTo(bgView);
            make.top.equalTo(self.contentImage.mas_bottom);
        }];
    }
    return self;
}

- (void)loadTheCellWith:(LivingModel *)item{
    self.titleLabel.text = item.videoTitle;
    [self.contentImage sd_setImageWithURL:[NSURL URLWithString:item.thumbnail]];
    self.detailLabel.text = item.anchorId;
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
