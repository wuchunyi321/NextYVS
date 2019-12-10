//
//  BrokersTableViewCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/10/15.
//  Copyright © 2019 cy. All rights reserved.
//

#import "BrokersTableViewCell.h"
#import "SecuritiesCompanyModel.h"

@interface BrokersTableViewCell()

@property (nonatomic,strong)UIImageView *logoImage;

@property (nonatomic,strong)UILabel   *titleLabel;

@property (nonatomic,strong)UILabel   *subTitle;

@property (nonatomic,strong)UIButton *openBtn;

@end

@implementation BrokersTableViewCell

- (UIButton *)openBtn{
    if (!_openBtn) {
        _openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_openBtn setTitle:@"立即开户" forState:UIControlStateNormal];
        [_openBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_openBtn.titleLabel setFont:[UserContext getTheFontWithName:@"PingFang-SC-Medium" size:14]];
        [_openBtn addTarget:self action:@selector(handleOpen:) forControlEvents:UIControlEventTouchUpInside];
        _openBtn.backgroundColor = RGBCOLOR(255, 52, 58);
        _openBtn.layer.cornerRadius = 4;
        _openBtn.layer.masksToBounds = YES;
    }
    return _openBtn;
}


- (UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage = [UIImageView new];
    }
    return _logoImage;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = RGBCOLOR(34, 34, 34);
        _titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:14];
    }
    return _titleLabel;
}

- (UILabel *)subTitle{
    if (!_subTitle) {
        _subTitle = [UILabel new];
        _subTitle.textAlignment = NSTextAlignmentLeft;
        _subTitle.textColor = RGBCOLOR(64, 64, 64);
        _subTitle.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
    }
    return _subTitle;
}

- (void)handleOpen:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(clickWithIndex:)]) {
        [_delegate performSelector:@selector(clickWithIndex:) withObject:[NSNumber numberWithInteger:sender.tag]];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(0xf3f3f4);
        [self.contentView addSubview:self.logoImage];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subTitle];
        
        [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(40);
        }];
        
        [self.contentView addSubview:self.openBtn];
        
        [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(23);
            make.right.equalTo(self.contentView).offset(-12);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(15);
            make.left.equalTo(self.logoImage.mas_right).offset(14);
            make.right.equalTo(self.openBtn.mas_left).offset(-20);
            make.height.mas_equalTo(15);
        }];
        
        [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
           make.left.equalTo(self.logoImage.mas_right).offset(14);
           make.right.equalTo(self.openBtn.mas_left).offset(-20);
           make.height.mas_equalTo(15);
        }];
        
        UIView *underLine = [UIView new];
        underLine.backgroundColor = UIColorFromRGB(0xeeeeee);
        [self.contentView addSubview:underLine];
        [underLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(5);
        }];
    }
    return self;
}


- (void)loadTheCellWith:(SecuritiesCompanyModel *)item withIndex:(NSInteger)index{
    self.titleLabel.text = item.companyName;
    self.subTitle.text = item.companyIntroduce;
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:item.companyLogo] placeholderImage:[UIImage imageNamed:@"BRSource.bundle/default_image"]];
    self.openBtn.tag = index+1;
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
