//
//  ReportNormalCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/2.
//  Copyright © 2019 cy. All rights reserved.
//

#import "ReportNormalCell.h"
#import "ReportListModel.h"
#import "StockModel.h"
#import <YYText/YYText.h>
#import <YYImage/YYImage.h>

@interface ReportNormalCell()

@property (nonatomic,strong)YYLabel *titleLabel;

@property (nonatomic,strong)UILabel *dateLabel;

@property (nonatomic,strong)UILabel *lookLabel;
@property (nonatomic,strong)UIImageView *logoImage;

@end

@implementation ReportNormalCell

- (YYLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[YYLabel alloc] init];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}


- (UILabel *)lookLabel{
    if (!_lookLabel) {
        _lookLabel = [UILabel new];
        _lookLabel.textAlignment = NSTextAlignmentLeft;
        _lookLabel.textColor = RGBCOLOR(98, 98, 98);
        _lookLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
    }
    return _lookLabel;
}

- (UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BRSource.bundle/report_logo1"]];
    }
    return _logoImage;
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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.logoImage];
        [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(87);
            make.height.mas_equalTo(61);
        }];
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.logoImage.mas_left).offset(-20);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-30);
        }];
        
        [self.contentView addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.height.mas_equalTo(12);
            make.width.mas_equalTo(100);
        }];
        
        [self.contentView addSubview:self.lookLabel];
        [self.lookLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.logoImage.mas_left).offset(-20);
            make.width.mas_equalTo(30);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.height.mas_equalTo(12);
        }];
        
        UIImageView *lookImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BRSource.bundle/pViews"]];
        [self.contentView addSubview:lookImage];
        [lookImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(16);
            make.height.mas_equalTo(11);
            make.right.equalTo(self.lookLabel.mas_left).offset(-2);
            make.bottom.equalTo(self.contentView).offset(-10);
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
    // 图文混排部分
    NSString *imageName = item.grade.intValue>2?@"BRSource.bundle/report_class_thr":(item.grade.intValue>1?@"BRSource.bundle/report_class_two":@"BRSource.bundle/report_class_one");
    NSString *content = [NSString stringWithFormat:@"%@ %@",imageName,item.rrName];
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:content];
    [result addAttribute:NSForegroundColorAttributeName
                   value:RGBCOLOR(34, 34, 34)
                   range:NSMakeRange(0, content.length)];
    [result addAttribute:NSFontAttributeName
                   value:[UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14]
                   range:NSMakeRange(0 , content.length)];
    
    if (item.grade.intValue > 0) {
        UIImage *image = [UIImage imageNamed:imageName];
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(30, 15) alignToFont:[UIFont systemFontOfSize:14] alignment:YYTextVerticalAlignmentCenter];
        NSRange range = NSMakeRange(0, 32);
        [result replaceCharactersInRange:range withAttributedString:attachText];
    }else{
        NSRange range = NSMakeRange(0, 32);
        [result replaceCharactersInRange:range withAttributedString:[[NSAttributedString alloc] initWithString:@""]];
    }
    self.titleLabel.attributedText = result;
    self.dateLabel.text = [NSString stringWithFormat:@"研报 %@",[item.addTime substringToIndex:10]];
    self.lookLabel.text = item.clicks;
}

- (void)loadStockTheCellWith:(StockModel *)item{
    self.titleLabel.text = item.shareTitle;
    self.dateLabel.text = [NSString stringWithFormat:@"文章 %@",[item.addTime substringToIndex:10]];
    self.lookLabel.text = item.clicks;
}

/**
 test
 */
-(void)loadTheCell:(NSString *)tittle date:(NSString *)date{
    self.titleLabel.text = tittle;
    self.dateLabel.text = date;
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
