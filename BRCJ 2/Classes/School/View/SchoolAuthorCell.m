//
//  SchoolAuthorCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/9/23.
//  Copyright © 2019 cy. All rights reserved.
//

#import "SchoolAuthorCell.h"

#import "AnchorModel.h"

@interface SchoolAuthorCell()

@property (nonatomic,strong)UIImageView            *reporterAvatar;
@property (nonatomic,strong)UILabel                *reporterName;
@property (nonatomic,strong)UILabel                *reporterOtherInfo;

@end


@implementation SchoolAuthorCell

- (UIImageView *)reporterAvatar{
    if (!_reporterAvatar) {
        _reporterAvatar = [[UIImageView alloc] init];
    }
    return _reporterAvatar;
}

- (UILabel *)reporterName{
    if (!_reporterName) {
        _reporterName = [UILabel new];
        _reporterName.textAlignment = NSTextAlignmentLeft;
        _reporterName.textColor = RGBCOLOR(0, 0, 0);
        _reporterName.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
    }
    return _reporterName;
}

- (UILabel *)reporterOtherInfo{
    if (!_reporterOtherInfo) {
        _reporterOtherInfo = [UILabel new];
        _reporterOtherInfo.textAlignment = NSTextAlignmentLeft;
        _reporterOtherInfo.textColor = RGBCOLOR(84, 84, 84);
        _reporterOtherInfo.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
    }
    return _reporterOtherInfo;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *title = [UILabel new];
        title.text = @"牛人主播";
        title.textColor = RGBCOLOR(255, 52, 58);
        title.textAlignment = NSTextAlignmentLeft;
        title.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:15];
        [self.contentView addSubview:title];
        title.frame = CGRectMake(16, 10, SCREEN_WIDTH-32, 25);
        
        [self.contentView addSubview:self.reporterAvatar];
        self.reporterAvatar.frame = CGRectMake(21, 13+25, 45, 45);
        
        [self.contentView addSubview:self.reporterName];
        self.reporterName.frame = CGRectMake(15+21+45, 13+25+4, SCREEN_WIDTH-(15+21+45+16), 15);
        
        [self.contentView addSubview:self.reporterOtherInfo];
        self.reporterOtherInfo.frame = CGRectMake(15+21+45, 13+25+4+15+10, SCREEN_WIDTH-(15+21+45+16), 15);
        
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

- (void)loadTheCellWith:(AnchorModel *)item avatar:(nonnull NSString *)avatarUrl{
    [self.reporterAvatar sd_setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[UIImage imageNamed:@"BRSource.bundle/report_avatar_default"]];
    self.reporterName.text = item.anchorName;
    self.reporterOtherInfo.text = item.anchorLabel;
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
