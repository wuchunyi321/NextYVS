//
//  SchoolCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import "SchoolCell.h"

#import "SchoolListItem.h"
#import "StockModel.h"

@interface SchoolCell()

@property (nonatomic,strong)UIImageView *iconImage;//100*79

@property (nonatomic,strong)UILabel     *titlelabel;
@property (nonatomic,strong)UILabel     *contentLabel;
@property (nonatomic,strong)UILabel     *lookLabel;
@property (nonatomic,strong)UILabel     *dateLabel;

@property (nonatomic,strong)UIImageView  *levelImage;


@end

@implementation SchoolCell

- (UIImageView *)levelImage{
    if (!_levelImage) {
        _levelImage = [[UIImageView alloc] init];
    }
    return _levelImage;
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
        _lookLabel.textAlignment = NSTextAlignmentLeft;
        _lookLabel.textColor = RGBCOLOR(98, 98, 98);
        _lookLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
    }
    return _lookLabel;
}

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
    }
    return _iconImage;
}

- (UILabel *)titlelabel{
    if (!_titlelabel) {
        _titlelabel = [UILabel new];
        _titlelabel.textColor = RGBCOLOR(34, 34, 34);
        _titlelabel.textAlignment = NSTextAlignmentLeft;
        _titlelabel.preferredMaxLayoutWidth = SCREEN_WIDTH-(12+100+8+12);
        _titlelabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
    }
    return _titlelabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = RGBCOLOR(130, 128, 128);
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconImage];
        [self.contentView addSubview:self.titlelabel];
        [self.contentView addSubview:self.contentLabel];
        
        [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(79);
            make.width.mas_equalTo(100);
            make.left.equalTo(self.contentView).offset(12);
            make.centerY.equalTo(self.contentView);
        }];
        
        //video_default
        UIImageView *vedioIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"video_default"]];
        [self.iconImage addSubview:vedioIcon];
        [vedioIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.iconImage);
            make.centerY.equalTo(self.iconImage);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(22);
        }];
        
        //levelImage
        [self.iconImage addSubview:self.levelImage];
        [self.levelImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(27);
            make.height.mas_equalTo(15);
            make.right.equalTo(self.iconImage).offset(-2);
            make.top.equalTo(self.iconImage).offset(2);
        }];
        
        self.titlelabel.frame = CGRectMake(12+100+8, 15, SCREEN_WIDTH-(12+100+8+12), 14);
        self.contentLabel.frame = CGRectMake(12+100+8, 15+14+15, SCREEN_WIDTH-(12+100+8+12), 108-(15+14+15+5)-20);
        
        [self.contentView addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImage.mas_right).offset(8);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(5);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(12);
        }];
        
        [self.contentView addSubview:self.lookLabel];
        self.lookLabel.frame = CGRectMake(SCREEN_WIDTH-46, 85, 30, 12);
        
        UIImageView *lookImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pViews"]];
        [self.contentView addSubview:lookImage];
        lookImage.frame = CGRectMake(SCREEN_WIDTH-46-2-16, 85, 16, 11);
        
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

- (void)loadTheCellWith:(SchoolListItem *)item{
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:item.thumbnail] placeholderImage:[UIImage imageNamed:@"default_image"]];
    NSString *imageName = item.grade.intValue>2?@"report_class_thr":(item.grade.intValue>1?@"report_class_two":@"report_class_one");
    self.levelImage.image = [UIImage imageNamed:imageName];
    if (item.grade.intValue == 0) {
        self.levelImage.hidden = YES;
    }else
        self.levelImage.hidden = NO;
    self.titlelabel.text = item.videoTitle;
    self.contentLabel.text = item.introduction;
    self.lookLabel.text = item.clicks;
    self.dateLabel.text = [item.updateTime substringToIndex:10];
}

- (void)loadTheStockWith:(StockModel *)item{
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:item.thumbnail] placeholderImage:[UIImage imageNamed:@"default_image"]];
        NSString *imageName = item.grade.intValue>2?@"report_class_thr":(item.grade.intValue>1?@"report_class_two":@"report_class_one");
    self.levelImage.image = [UIImage imageNamed:imageName];
    if (item.grade.intValue == 0) {
        self.levelImage.hidden = YES;
    }else
        self.levelImage.hidden = NO;
    self.titlelabel.text = item.shareTitle;
    self.contentLabel.text = item.introduction;
    self.lookLabel.text = item.clicks;
    self.dateLabel.text = [item.updateTime substringToIndex:10];
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
