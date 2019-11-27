//
//  MinePayCell.m
//  BRCJ
//
//  Created by wuchunyi on 2019/11/26.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MinePayCell.h"

@interface MinePayCell()

/**
 背景
 */
@property (nonatomic,strong)UIView  *bgView;
/**
 充值等级
 */
@property (nonatomic,strong)UILabel  *titleLabel;
/**
 充值成功与否图片
 */
@property (nonatomic,strong)UIImageView  *successImage;
/**
 订单编号
 */
@property (nonatomic,strong)UILabel   *orderLabel;
/**
 订单金额
 */
@property (nonatomic,strong)UILabel   *orderPriceLabel;
/**
 交易号
 */
@property (nonatomic,strong)UILabel   *payNumberLabel;
/**
 创建时间
 */
@property (nonatomic,strong)UILabel  *orderCreateTimeLabel;
/**
 联系我们
 */
@property (nonatomic,strong)UIButton  *callUsBtn;

@end

@implementation MinePayCell

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:15];
        _titleLabel.layer.cornerRadius = 10;
        _titleLabel.layer.masksToBounds = YES;
    }
    return _titleLabel;
}

- (UIImageView *)successImage{
    if (!_successImage) {
        _successImage = [[UIImageView alloc] init];
    }
    return _successImage;
}

- (UILabel *)orderLabel{
    if (!_orderLabel) {
        _orderLabel = [UILabel new];
        _orderLabel.textColor = RGBCOLOR(85, 85, 85);
        _orderLabel.textAlignment = NSTextAlignmentLeft;
        _orderLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
    }
    return _orderLabel;
}

- (UILabel *)orderPriceLabel{
    if (!_orderPriceLabel) {
        _orderPriceLabel = [UILabel new];
        _orderPriceLabel.textColor = RGBCOLOR(85, 85, 85);
        _orderPriceLabel.textAlignment = NSTextAlignmentLeft;
        _orderPriceLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
    }
    return _orderPriceLabel;
}

- (UILabel *)payNumberLabel{
    if (!_payNumberLabel) {
        _payNumberLabel = [UILabel new];
        _payNumberLabel.textColor = RGBCOLOR(85, 85, 85);
        _payNumberLabel.textAlignment = NSTextAlignmentLeft;
        _payNumberLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
        _payNumberLabel.numberOfLines = 2;
    }
    return _payNumberLabel;
}

- (UILabel *)orderCreateTimeLabel{
    if (!_orderCreateTimeLabel) {
        _orderCreateTimeLabel = [UILabel new];
        _orderCreateTimeLabel.textColor = RGBCOLOR(85, 85, 85);
        _orderCreateTimeLabel.textAlignment = NSTextAlignmentLeft;
        _orderCreateTimeLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
    }
    return _orderCreateTimeLabel;
}


- (void)handleCall{
    if (self.backBlock) {
        self.backBlock();
    }
}

- (UIButton *)callUsBtn{
    if (!_callUsBtn) {
        _callUsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_callUsBtn addTarget:self action:@selector(handleCall) forControlEvents:UIControlEventTouchUpInside];
        [_callUsBtn setTitle:@"联系我们" forState:UIControlStateNormal];
        [_callUsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _callUsBtn.titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:13];
        _callUsBtn.backgroundColor = RGBCOLOR(239, 101, 58);
        _callUsBtn.layer.cornerRadius = 5;
        _callUsBtn.layer.masksToBounds = YES;
    }
    return _callUsBtn;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(0xf3f3f4);
        [self.contentView addSubview:self.bgView];
        
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.successImage];
        [self.bgView addSubview:self.orderLabel];
        [self.bgView addSubview:self.orderPriceLabel];
        [self.bgView addSubview:self.orderCreateTimeLabel];
        [self.bgView addSubview:self.payNumberLabel];
        [self.bgView addSubview:self.callUsBtn];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(14);
            make.right.equalTo(self.contentView).offset(-14);
            make.height.mas_equalTo(223);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(8);
            make.top.equalTo(self.bgView).offset(13);
            make.height.mas_equalTo(22);
            make.width.mas_equalTo(100);
        }];
        
        [self.successImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(self.bgView);
            make.width.height.mas_equalTo(50);
        }];
        
        [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(8);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
            make.height.mas_equalTo(15);
            make.right.equalTo(self.bgView);
        }];
        
        [self.orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(8);
            make.top.equalTo(self.orderLabel.mas_bottom).offset(13);
            make.height.mas_equalTo(15);
            make.right.equalTo(self.bgView);
        }];
        
        self.payNumberLabel.frame = CGRectMake(8, 13+22+20+15+13+15+13, SCREEN_WIDTH-28-16, 40);
        
//        [self.payNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.bgView).offset(8);
//            make.top.equalTo(self.orderPriceLabel.mas_bottom).offset(13);
//            make.height.mas_equalTo(30);
//            make.right.equalTo(self.bgView.mas_right).offset(-8);
//        }];
        
        [self.orderCreateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(8);
            make.top.equalTo(self.payNumberLabel.mas_bottom).offset(13);
            make.height.mas_equalTo(15);
            make.right.equalTo(self.bgView);
        }];
        
        [self.callUsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderCreateTimeLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(70);
            make.right.equalTo(self.bgView.mas_right).offset(-14);
        }];
    }
    return self;
}

- (void)loadTheCellWith:(MinePayModel *)item{
    if (item.orderStatus.intValue == 1) { //成功
        self.titleLabel.backgroundColor = RGBCOLOR(68, 136, 249);
        self.titleLabel.textColor = RGBCOLOR(48, 123, 249);
        self.successImage.image = [UIImage imageNamed:@"mine_Payed"];
    }else{ //失败
        self.titleLabel.backgroundColor = RGBCOLOR(255, 167, 0);
        self.titleLabel.textColor = RGBCOLOR(216, 141, 0);
        self.successImage.image = [UIImage imageNamed:@"mine_notPay"];
    }
    self.titleLabel.text = [BRTool getTheBackStrWithgradeStr:item.rechargeLevel isBackInt:NO];
    self.orderLabel.text = [NSString stringWithFormat:@"订单编号：%@",item.outTradeNo];
    self.orderPriceLabel.text = [NSString stringWithFormat:@"订单金额：%@元",item.totalPrice];
    self.payNumberLabel.text = [NSString stringWithFormat:@"%@：%@",item.payChannel.intValue==10?@"支付宝交易号":@"微信交易号",item.tradeNo.length>0?item.tradeNo:@""];
    self.orderCreateTimeLabel.text = [NSString stringWithFormat:@"创建时间：%@",item.orderDate];
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
