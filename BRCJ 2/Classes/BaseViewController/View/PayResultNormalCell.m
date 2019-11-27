//
//  PayResultNormalCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/11/27.
//  Copyright © 2019 cy. All rights reserved.
//

#import "PayResultNormalCell.h"

#import "DashedView.h"

@interface PayResultNormalCell()

@property (nonatomic,strong)UILabel *contentLabel;

@property (nonatomic,strong)UILabel *content1Label;

@property (nonatomic,strong)UILabel *content2Label;

@property (nonatomic,strong)DashedView *line;

@end


@implementation PayResultNormalCell

- (DashedView *)line{
    if (!_line) {
        _line = [DashedView new];
    }
    return _line;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
        _contentLabel.textColor = RGBCOLOR(85, 85, 85);
    }
    return _contentLabel;
}

- (UILabel *)content1Label{
    if (!_content1Label) {
        _content1Label = [UILabel new];
        _content1Label.textAlignment = NSTextAlignmentLeft;
        _content1Label.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
        _content1Label.textColor = RGBCOLOR(85, 85, 85);
    }
    return _content1Label;
}

- (UILabel *)content2Label{
    if (!_content2Label) {
        _content2Label = [UILabel new];
        _content2Label.textAlignment = NSTextAlignmentLeft;
        _content2Label.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
        _content2Label.textColor = RGBCOLOR(85, 85, 85);
    }
    return _content2Label;
}

/**
 
 */
- (void)loadTheCellWith:(NSString *)content{
    self.content1Label.hidden = YES;
    self.content2Label.hidden = YES;
    self.contentLabel.text = content;
    self.line.frame = CGRectMake(0, 45, SCREEN_WIDTH, 0.5);
}
/**
 
 */
- (void)loadTheCellWith:(NSString *)content
               content1:(NSString *)content1
               content2:(NSString *)content2{
    self.content1Label.hidden = NO;
    self.content2Label.hidden = NO;
    self.contentLabel.text = content;
    self.content1Label.text = content1;
    self.content2Label.text = content2;
    self.line.frame = CGRectMake(0, 105, SCREEN_WIDTH, 0.5);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.content1Label];
        [self.contentView addSubview:self.content2Label];
        [self.contentView addSubview:self.line];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(15);
            make.height.mas_equalTo(15);
        }];
        
        [self.content1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(15);
            make.height.mas_equalTo(15);
        }];
        
        [self.content2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.content1Label.mas_bottom).offset(15);
            make.height.mas_equalTo(15);
        }];
    }
    return self;
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
