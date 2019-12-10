//
//  MineCardListCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/6.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineCardListCell.h"

#import "MineCardImageView.h"

#import "BankCardModel.h"

@interface MineCardListCell()

@property (nonatomic,strong)MineCardImageView *card;

@end


@implementation MineCardListCell

- (MineCardImageView *)card{
    if (!_card) {
        _card = [[MineCardImageView alloc] initWithImage:[UIImage imageNamed:@"BRSource.bundle/mine_card"]];
    }
    return _card;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.card];
        [self.card mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.width.mas_equalTo(CARDWIDTH);
            make.height.mas_equalTo(CARDHEIGHT);
            make.top.equalTo(self.contentView).offset(5);
        }];
    }
    return self;
}

/** 测试数据 **/
-(void)loadTheCardImageWith:(NSString *)title
                       info:(NSString *)info
                   isChoose:(BOOL)ischoose
                   hasArrow:(BOOL) hasArrow{
    [self.card loadTheCardImageWith:title
                               info:info
                           isChoose:ischoose
                           hasArrow:hasArrow];
}

- (void)loadTheCellWith:(BankCardModel *)model{
    [self.card loadTheCardImageWith:model.bankName
                               info:[NSString stringWithFormat:@"尾号为%@ 储蓄卡",[model.bankCardNumber substringFromIndex:model.bankCardNumber.length-4]]
                           isChoose:(model.isDefault.intValue != 1)
                           hasArrow:YES];
}


- (void)loadTheListCellWith:(BankCardModel *)model{
    [self.card loadTheCardImageWith:model.bankName
                               info:[NSString stringWithFormat:@"尾号为%@ 储蓄卡",[model.bankCardNumber substringFromIndex:model.bankCardNumber.length-4]]
                           isChoose:(model.isDefault.intValue != 1)
                           hasArrow:NO];
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
