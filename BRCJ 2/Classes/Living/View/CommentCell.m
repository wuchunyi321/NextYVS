//
//  CommentCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/9/19.
//  Copyright © 2019 cy. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"

@interface CommentCell()

@property (nonatomic,strong)UILabel  *transferLabel;

@end


@implementation CommentCell

- (UILabel *)transferLabel{
    if (!_transferLabel) {
        _transferLabel = [UILabel new];
    }
    return _transferLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(0xf3f3f4);
        [self.contentView addSubview:self.transferLabel];
        [self.transferLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.contentView).offset(8);
            make.right.equalTo(self.contentView).offset(-13);
            make.bottom.equalTo(self.contentView).offset(-8);
        }];
    }
    return self;
}

- (void)loadTheCellWith:(CommentModel *)item{
    NSMutableAttributedString  *attriText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:%@",item.nickname,item.content]];
    [attriText addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(0, 127, 253) range:NSMakeRange(0,item.nickname.length+1)];
    [attriText addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(34, 34, 34) range:NSMakeRange(item.nickname.length+1,item.content.length)];
    [attriText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, attriText.length)];
    self.transferLabel.attributedText = attriText;
    self.transferLabel.textAlignment = NSTextAlignmentLeft;
    self.transferLabel.numberOfLines = 2;
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
