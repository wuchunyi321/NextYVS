//
//  MineHomeTableCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/30.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineHomeTableCell.h"

@interface MineHomeTableCell()

@property (nonatomic,strong)UIImageView *iconImage;

@property (nonatomic,strong)UILabel     *titlelabel;

@property (nonatomic,strong)UIImageView  *arrowImage;

@property (nonatomic,strong)UIView       *underLine;

@end

@implementation MineHomeTableCell

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
    }
    return _iconImage;
}

- (UILabel *)titlelabel{
    if (!_titlelabel) {
        _titlelabel = [UILabel new];
        _titlelabel.textColor = RGBCOLOR(37, 37, 37);
        _titlelabel.textAlignment = NSTextAlignmentLeft;
        _titlelabel.font = [UIFont systemFontOfSize:14];
    }
    return _titlelabel;
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
        
        [self.contentView addSubview:self.iconImage];
        [self.contentView addSubview:self.titlelabel];
        [self.contentView addSubview:self.arrowImage];
        [self.contentView addSubview:self.underLine];
        
        [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.with.mas_equalTo(18);
            make.left.equalTo(self.contentView).offset(16);
            make.centerY.equalTo(self.contentView);
        }];
        
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImage.mas_right).offset(8);
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
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
            make.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)loadTheCellWithType:(MineHomeTableCellType )type{
    switch (type) {
        case MineHomeTableCellTypeInvate:{
            self.underLine.hidden = NO;
            self.iconImage.image = [UIImage imageNamed:@"BRSource.bundle/mine_invite"];
            self.titlelabel.text = @"邀请";
        }
            break;
        case MineHomeTableCellTypeAboutUs:{
            self.underLine.hidden = NO;
            self.iconImage.image = [UIImage imageNamed:@"BRSource.bundle/mine_about_us"];
            self.titlelabel.text = @"关于我们";
        }
            break;
        case MineHomeTableCellTypeReport:{
            self.underLine.hidden = NO;
            self.iconImage.image = [UIImage imageNamed:@"BRSource.bundle/mine_statement"];
            self.titlelabel.text = @"免责声明";
        }
            break;
        case MineHomeTableCellTypeMyFriends:{
            self.underLine.hidden = NO;
            self.iconImage.image = [UIImage imageNamed:@"BRSource.bundle/mine_friends"];
            self.titlelabel.text = @"我的好友";
        }
            break;
        case MineHomeTableCellTypeCallUs:{
            self.underLine.hidden = NO;
            self.iconImage.image = [UIImage imageNamed:@"BRSource.bundle/mine_call_us"];
            self.titlelabel.text = @"联系我们";
        }
            break;
        case MineHomeTableCellTypeSet:{
            self.underLine.hidden = YES;
            self.iconImage.image = [UIImage imageNamed:@"BRSource.bundle/mine_set"];
            self.titlelabel.text = @"设置";
        }
            break;
        case MineHomeTableCellTypePay:{
            self.underLine.hidden = YES;
            self.iconImage.image = [UIImage imageNamed:@"BRSource.bundle/mine_pay"];
            self.titlelabel.text = @"订单列表";
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
